package fuzzy.http;

import sys.net.Socket;

enum abstract Method(String) from String to String {
	final HEAD = "HEAD";
	final GET = "GET";
	final POST = "POST";
	final PUT = "PUT";
	final DELETE = "DELETE";
	final PATCH = "PATCH";

	final CONNECT = "CONNECT";
	final OPTIONS = "OPTIONS";
	final QUERY = "QUERY";
	final TRACE = "TRACE";
}

enum abstract Version(String) from String to String {
  final HTTP0_9 = "HTTP/0.9";
  final HTTP1_0 = "HTTP/1.0";
  final HTTP1_1 = "HTTP/1.1";
  final HTTP2 = "HTTP/2";
  final HTTP3 = "HTTP/3";
}

@:forward
abstract Cookies(Map<String, String>) {
	public function new() {
		this = new Map();
	}

	public function get(key: String) {
		return this.get(key);
	}
}

@:struct
@:structInit
@:publicFields
class Request {
	var method: Method;
  var path: String;
  var version: Version;

	var headers: Headers = new Headers();

	var cookies: Cookies = new Cookies();

	var socket: Socket;
}
