package fuzzy.http;

import fuzzy.http.Response.Status;
import fuzzy.http.Request.Version;
import sys.net.AsyncSocket;
import haxe.ds.WeakMap;
import haxe.io.Eof;
// import hxcoro.schedulers.ThreadAwareScheduler;
// import hxcoro.dispatchers.ThreadPoolDispatcher;
// import hxcoro.thread.FixedThreadPool;
// import hxcoro.Coro.*;
// import hxcoro.CoroRun;

import sys.net.Host;
import sys.net.Socket;

using Math;
using StringTools;

class Server {
  final host: Host;
  final port: Int;

  public function new(?host: Host, ?port: Int) {
    this.host = host ?? new Host("0.0.0.0");
    this.port = port ?? 3000;
  }

  public function start() {
    var socket = new Socket();
    
    socket.setFastSend(true);
    socket.setTimeout(3600);
    socket.setBlocking(false);
    
    socket.bind(host, port);

    trace('started http server at ${host.host}:$port'); // make it a callback?
    socket.listen(8);

    while(true) {
      var client = socket.accept();
      if(client != null) {
        // todo: use different coroutine lib
        // CoroRun.run(_ -> process(client));
        process(client);
      }
    }
  }

  dynamic public function handle(request: Request): Response {
    return new Response();
  }

  function read_headers(input: haxe.io.Input) {
    var headers: Map<String, String> = new Map();
    
    try while(true) {
      var line = input.readLine();

      if(line == "")
        break;

      // todo: beter
      var header_split = line.split(":");
      final name = header_split[0]?.trim(); // same here
      final value = header_split[1]?.trim(); // prob not needed 
      
      headers.set(name, value);
    } catch(e: Eof) {
      trace('failed reading client headers: $e');
    }

    return headers;
  }


  // @:coroutine 
  function process(client: Socket) {
    trace('got connection: ${client.peer()}');

    client.waitForRead();

    var protocol: String = null;
    try while(protocol == null) {
      var line = client.input.readLine();

      if(line != "\n" || line != "")
        protocol = line;
    }catch(e: Eof) {
      trace('failed reading client protocol: $e'); // todo: proper logging
      return;
    };

    final protocol_split = protocol.split(" ");

    if(protocol_split.length < 2) {
      trace('invalid protocol');
      client.output.writeString('HTTP/1.0 ${Status.BadRequest}'); // is this right? idk
      client.close();
      return;
    }

    final method = protocol_split[0];
    final path = protocol_split[1];
    final version: Version = protocol_split[2] ?? HTTP1_0;

    final request_headers = read_headers(client.input);
    trace('request headers: ${request_headers}');

    trace("sending body:");

    try switch version {
      // while these aren't implemented, we should downgrade the request

      // case HTTP3: 
      //   client.output.writeString('$version 400');
      //   client.output.writeString(Server.NEWLINE);
      //   client.output.flush();
        
      // case HTTP2: 
      //   client.output.writeString('$version 400');
      //   client.output.writeString(Server.NEWLINE);
      //   client.output.flush();
      
      case HTTP1_1: 

        var request: Request = {
          method: method,
          path: path,
          version: version,

          socket: client
        };

        var response = handle(request);

        client.output.writeString('HTTP/1.0 ${response.status}');
        client.output.writeString('\r\n');

        // on http 1.1 we dont need this, we should use <smth else that i forgot, see rfc> 
        client.output.writeString('content-length: ${response.content?.length ?? 0}');
        client.output.writeString('\r\n');
        
        final headers = response.headers.toString();
        client.output.writeString(headers);

        client.output.writeString('\r\n');
        client.output.writeString('${response.content ?? ''}');

        client.output.flush();

        process(client);

      case HTTP1_0, _:    
        var request: Request = {
          method: method,
          path: path,
          version: version,

          socket: client
        };

        var response = handle(request);

        client.output.writeString('HTTP/1.0 ${response.status}');
        client.output.writeString('\r\n');

        client.output.writeString('content-length: ${response.content?.length ?? 0}');
        client.output.writeString('\r\n');
        
        final headers = response.headers.toString();
        client.output.writeString(headers);

        client.output.writeString('\r\n');
        client.output.writeString('${response.content ?? ''}');

        client.output.flush();

    } catch(e: Eof) {
      trace('failed to send output to client $e');
    }

    client.close();
  }
}