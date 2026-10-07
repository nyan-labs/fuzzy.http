package fuzzy.http;

import haxe.EnumTools;
import fuzzy.http.Request.Protocol;
import haxe.ds.Option;
import fuzzy.http.Request.Method;
import fuzzy.http.Workers;
import sys.thread.Thread;
import sys.thread.ThreadImpl;
import fuzzy.http.Headers.HeaderName;
import fuzzy.http.Response.Status;
import fuzzy.http.Request.Version;
import haxe.io.Eof;

import sys.net.Host;
import sys.net.Socket;

using Std;
using Math;
using StringTools;

@:nullSafety(StrictThreaded)
class Server {
  public final host: Host;
  public final port: Int;
  
  var workers: Workers; 
  
  // since my main goal is a hashlink webserver, shouldn't we be using the std's libuv Tcp for hashlink? 
  public final socket = new Socket();
  public function new(?host: Host, ?port: Int) {
    this.host = host ?? new Host("0.0.0.0");
    this.port = port ?? 3000;

    socket.bind(this.host, this.port);
    
    socket.setFastSend(true);
    socket.setTimeout(3600);
    socket.setBlocking(false);
    
    workers = new Workers(16, Type.getClassName(Server));
    workers.work();
  }
  
  
  public function start() {
    socket.listen(256);

    trace('started http server at ${host.host}:$port'); // make it a callback?

    while(true) {
      var client = socket.accept();
      
      if(client != null) {
        workers.add(() -> process(client));
      }
    }
  }

  dynamic public function handle(request: Request): Response {
    return new Response();
  }

  function read_headers(input: haxe.io.Input): Option<Headers> {
    var headers: Map<String, String> = new Map();
    
    try while(true) {
      var line = input.readLine();

      if(line == "")
        break;

      // todo: beter
      var header_split = line.split(":");
      final name = header_split[0]?.trim(); // same here
      final value = header_split[1]?.trim(); // prob not needed 
      
      if(name == null || value == null)
        continue;
      
      headers.set(name, value);
    } catch(e: Eof) {
      trace('failed reading client headers: $e');

      return None;
    }

    return Some(headers);
  }

  function read_protocol(client: Socket): Option<Protocol> {
    try while(true) {
      var line = client.input.readLine();

      if(line == "")
        continue;
        
      var split = line.split(" ");

      if(split.length < 2) {
        trace('invalid protocol (got `$line`)');
        client.output.writeString('HTTP/1.0 ${Status.HTTPVersionNotSupported}');
        client.close();
        return None;
      }

      final method: Method = split[0];
      final path: String = split[1];
      final version: Version = split[2] ?? HTTP0_9;

      return Some({
        method: method,
        path: path,
        version: version
      });
    } catch(e: Eof) {
      trace('failed reading client protocol: $e'); // todo: proper logging
      return None;
    };
  }


  function process(client: Socket) {
    trace('got connection: ${client.peer()}');

    client.waitForRead(); // todo: timeout, we can't let it hang a connection

    final protocol = switch read_protocol(client) {
      case Some(v): v;
      case None: return;
    }

    final request_headers = switch read_headers(client.input) {
      case Some(v): v;
      case None: new Headers();
    }

    try switch protocol.version {
      case version if(!version.startsWith("HTTP/")):
        trace('invalid http version (got $version)');

        client.output.writeString('HTTP/1.0 ${Status.HTTPVersionNotSupported}');

      // this is kept as a gimmick
      case HTTP0_9:
        #if fuzzy.http.enable_http0_9
        var request: Request = {
          protocol: protocol,

          socket: client
        };

        var response = handle(request);

        client.output.writeString('${response.content ?? ''}');

        client.output.flush();
        #else
        client.output.writeString('HTTP/1.0 ${Status.HTTPVersionNotSupported}');
        #end
        
      case HTTP1_0:
        var request: Request = {
          protocol: protocol,

          socket: client
        };

        var response = handle(request);

        client.output.writeString('HTTP/1.0 ${response.status}');
        client.output.writeString('\r\n');

        if(!response.headers.exists(ContentLength)) 
          response.headers.set(ContentLength, (response.content?.length ?? 0).string());

        final headers = response.headers.string();
        trace("sending headers:", headers);
        client.output.writeString(headers);

        client.output.writeString('\r\n');
        client.output.writeString('${response.content ?? ''}');

        client.output.flush();
      
      case HTTP1_1, _: 
        var request: Request = {
          protocol: protocol,

          socket: client
        };

        var response = handle(request);

        client.output.writeString('HTTP/1.1 ${response.status}');
        client.output.writeString('\r\n');

        // on http 1.1 we dont need this, we should use <smth else that i forgot, see rfc>
        if(!response.headers.exists(ContentLength)) 
          response.headers.set(ContentLength, (response.content?.length ?? 0).string());
        
        final headers = response.headers.string();
        trace("sending headers:", headers);
        client.output.writeString(headers);

        client.output.writeString('\r\n');
        client.output.writeString('${response.content ?? ''}');

        client.output.flush();

        process(client);

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
      trace('failed to send output to client $e');
    }

    client.close();
  }
}