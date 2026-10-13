package fuzzy.http;

import hl.Gc;
import haxe.EventLoop;
import haxe.io.Eof;

import fuzzy.log.Logger;
import fuzzy.ds.Result;
import fuzzy.http.Request.Method;
import fuzzy.http.Request.Protocol;
import fuzzy.http.Request.Version;
import fuzzy.http.Response.Status;

import sys.net.Host;
import sys.net.Socket;

using Std;
using Math;
using StringTools;

@:nullSafety(StrictThreaded)
class Server {
  final logger: Logger;

  public final host: Host;
  public final port: Int;

  // since my main goal is a hashlink webserver, shouldn't we be using the std's libuv Tcp for hashlink?
  public final socket = new Socket();

  // var workers: Workers;

  public function new(?host: Host, ?port: Int) {
    logger = new Logger(Type.getClassName(Server));

    this.host = host ?? new Host("0.0.0.0");
    this.port = port ?? 3000;

    socket.bind(this.host, this.port);

    socket.setFastSend(true);
    socket.setTimeout(3600); // doesnt do anything
    socket.setBlocking(false);
  }


  public function start() {
    socket.listen(256);
    logger.log(Dbg, 'started http server at ${host.host}:$port'); // make it a callback?

    while(true) {
      var client = socket.accept();

      if(client != null) {
        EventLoop.addTask(() -> process(client), false);
      }
    }
  }

  dynamic public function handle(request: Request): Response {
    return new Response();
  }

  function read_headers(input: haxe.io.Input): Result<Headers, String> {
    var headers: Headers = new Headers();

    try while(true) {
      var line = input.readLine();

      if(line == "")
        break;

      // todo: beter
      var header_split = line.split(":");
      final name = header_split[0]?.trim()?.toLowerCase(); // same here
      final value = header_split[1]?.trim(); // prob not needed

      if(name == null || value == null)
        continue;

      if(headers.exists(name))
        headers.get(name)?.push(value);
      else
        headers.set(name, [value]);
    } catch(e: Eof) {
      return Err('failed reading client headers: $e');
    }

    return Ok(headers);
  }

  function read_protocol(input: haxe.io.Input): Result<Protocol, String> {
    try while(true) {
      var line = input.readLine();

      if(line == "")
        continue;

      var split = line.split(" ");

      if(split.length < 2)
        return Err('invalid protocol (got `$line`)');

      final method: Method = split[0];
      final path: String = split[1];
      final version: Version = split[2] ?? HTTP0_9;

      return Ok({
        method: method,
        path: path,
        version: version
      });
    } catch(e: Eof) {
      return Err('failed reading client protocol: $e'); // todo: proper logging
    };
  }

  function process(client: Socket): Result<Bool, String> {
    if(client.peer() == null)
      return Err("client not connected"); // we should have proper exceptions, maybe

    logger.log(Dbg, 'got connection: ${client.peer()}');

    client.waitForRead();

    final protocol = switch read_protocol(client.input) {
      case Ok(v): v;
      case Err(e):
        logger.log(Err, e);

        client.output.writeString('HTTP/1.0 ${Status.HTTPVersionNotSupported}');
        client.close();
        return Err('reading protocol failed: $e');
    }

    final request_headers = switch read_headers(client.input) {
      case Ok(v): v;
      case Err(e):
        logger.log(Err, e);

        new Headers();
    }

    try switch protocol.version {
      case version if(!version.startsWith("HTTP/")):
        logger.log(Err, 'invalid http version (got $version)');

        client.output.writeString('${Version.HTTP1_0} ${Status.HTTPVersionNotSupported}');

      // this is kept as a gimmick
      case HTTP0_9:
        #if fuzzy.http.enable_http0_9
        var request: Request = {
          protocol: protocol,

          headers: request_headers,

          socket: client
        };

        var response = handle(request);

        client.output.writeString('${response.body ?? ''}');

        client.output.flush();
        #else
        client.output.writeString('${Version.HTTP1_0} ${Status.HTTPVersionNotSupported}');
        #end

      case HTTP1_0:
        var request: Request = {
          protocol: protocol,

          headers: request_headers,

          socket: client
        };

        logger.log(Dbg, 'handling ${request.protocol.method}');
        switch process_method(request) {
          case Ok(_): null;
          case Err(e):
            client.output.writeString('${Version.HTTP1_1} ${Status.BadRequest}');
            client.output.flush();

            client.close();
            return Err('failed handling ${request.protocol.method}: $e');
        }

      case HTTP1_1, _:
        var request: Request = {
          protocol: protocol,

          headers: request_headers,
          cookies: {
            var headers = request_headers;
            
            var cookies = new Cookies();
            for(name => values in headers) {
              if(name != Cookie)
                continue;

              for(value in values) {
                var split = value.split(";");
                for(s in split) {
                  var key_value = s.split("=");
                    
                  var key: Null<String> = key_value[0]?.trim() ?? null;
                  var value: Null<String> = key_value[1]?.trim() ?? null; 
  
                  if(key == null || value == null)
                    continue;
  
                  // sshhh null safety, its okay
                  cookies.set({
                    name: cast key,
                    value: cast value,
                    expiry: 0
                  });
                }
              }
            }

            cookies;
          },

          socket: client
        };

        // wait wait! by spec we are required to check if the client sent the Host header
        if(!request.headers.exists(Host)) {
          client.output.writeString('${Version.HTTP1_1} ${Status.BadRequest}');
          client.output.flush();

          client.close();
          return Err('missing host header, rejecting request');
        }

        logger.log(Dbg, 'handling ${request.protocol.method}');
        switch process_method(request) {
          case Ok(_): null;
          case Err(e):
            client.output.writeString('${Version.HTTP1_1} ${Status.BadRequest}');
            client.output.flush();

            client.close();
            return Err('failed handling ${request.protocol.method}: $e');
        }

      // while these aren't implemented, we should downgrade the request (by switch-case fallbacking)

      // case HTTP3:
      //   client.output.writeString('$version 400');
      //   client.output.writeString(Server.NEWLINE);
      //   client.output.flush();

      // case HTTP2:
      //   client.output.writeString('$version 400');
      //   client.output.writeString(Server.NEWLINE);
      //   client.output.flush();
    } catch(e: Eof) {
      logger.log(Dbg + Err, 'failed to send output to client $e');
    }

    client.close();
    return Ok(true);
  }

	function process_method(request: Request): Result<Bool, String> {
    final client = request.socket;

		switch request.protocol.method {
			case GET:
				var response = handle(request);

				client.output.writeString('${Version.HTTP1_1} ${response.status}');
				client.output.writeString('\r\n');

        // refactor: ugley
        response.headers.set(SetCookie, [
          for(name => cookie in response.cookies) {
            var value = new StringBuf();

            value.add('$name=${StringTools.urlEncode(cookie.value)}');

            value.add('; Max-Age=${cookie.expiry}');

            if(cookie.domain != null)
              value.add('; Domain=${cookie.domain}');
            if(cookie.path != null)
              value.add('; Path=${cookie.path}');

            if(cookie.samesite != null)
              value.add('; SameSite=${cookie.samesite}');

            if(cookie.secure != null && cookie.secure)
              value.add('; Secure');
            if(cookie.session != null && cookie.session)
              value.add('; Session');

            if(cookie.js != null && cookie.js == false)
              value.add('; HttpOnly');
            if(cookie.strict != null && cookie.strict)
              value.add('; HostOnly');

            value.toString();
          }
        ]);

				final headers = response.headers.headers();
				logger.log(Dbg, 'sending headers: $headers');
				client.output.writeString(headers);

				client.output.writeString('\r\n');
				logger.log(Dbg, 'sending body: ${response.body}');
				client.output.writeString('${response.body ?? ''}');

				client.output.flush();

				return process(client);

			case POST:
				var length:Null<Int> = null;
				if (!request.headers.exists(ContentLength)) {
					client.output.writeString('${Version.HTTP1_1} ${Status.LengthRequired}');
					client.output.flush();

					client.close();

					return Err("POST request is missing content-length");
				} else
					length = request.headers.first(ContentLength)?.parseInt();
				// todo!
				if (request.headers.exists(TransferEncoding)) {
					logger.log(Dbg + Warn, 'faced with an unimplemented method');
					client.output.writeString('${Version.HTTP1_1} ${Status.BadRequest}');
					client.output.flush();

					client.close();
					return Err("transfer-encoding is unfinished");
				}

				// client.output.writeString('${Version.HTTP1_1} ${Status.Continue}');
				// client.output.writeString('\r\n');

				logger.log(Dbg, 'waiting for POST body');
				client.waitForRead();

				// split this off too
				if (length != null) {
					logger.log(Dbg, 'going to read the body with the known length of $length');
					var i = 0;
					var body = "";

					try
						while (i < length) {
							body += client.input.readString(1);

							i++;
							// trace("hi", body);
						} catch (e:Eof)
						logger.log(Dbg + Err, 'eof\'d, fuck you too i guess $e');

					if (body.length != 0)
						request.body = body;
				}

				// trace('yoo we got da bodie', request.body);

				var response = handle(request);

				client.output.writeString('${Version.HTTP1_1} ${response.status}');
				client.output.writeString('\r\n');

				final headers = response.headers.headers();
				logger.log(Dbg, 'sending headers: $headers');
				client.output.writeString(headers);

				client.output.writeString('\r\n');
				logger.log(Dbg, 'sending body: ${response.body}');
				client.output.writeString('${response.body ?? ''}');

				client.output.flush();

        return Ok(true);
			// process(client);

			case _:
				logger.log(Dbg + Warn, 'faced with an unimplemented method');
				client.output.writeString('${Version.HTTP1_1} ${Status.BadRequest}');
				client.output.flush();

        return Err('unknown method ${request.protocol.method}');
		}
	}
}
