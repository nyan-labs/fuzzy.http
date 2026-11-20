package fuzzy.http;

enum abstract SameSite(String) {
	final STRICT = "strict";
	final LAX = "lax";
	final none = "none";
}

class CookieTools {
	static public function string(cookie: Cookie) {
		final buf = new StringBuf();

		final name = StringTools.urlEncode(cookie.name);
		final value = StringTools.urlEncode(cookie.value);

		buf.add('$name=$value');
		buf.add('; Max-Age=${cookie.expiry}');

		if(cookie.domain != null)
			buf.add('; Domain=${cookie.domain}');
		if(cookie.path != null)
			buf.add('; Path=${cookie.path}');

		if(cookie.samesite != null)
			buf.add('; SameSite=${cookie.samesite}');

		if(cookie.secure != null && cookie.secure)
			buf.add('; Secure');
		if(cookie.session != null && cookie.session)
			buf.add('; Session');

		if(cookie.js != null && cookie.js == false)
			buf.add('; HttpOnly');
		if(cookie.strict != null && cookie.strict)
			buf.add('; HostOnly');

		return buf.toString();
	}
}

@:using(fuzzy.http.Cookies.CookieTools)
typedef Cookie = {
	final name: String;

	var value: String;
	var ?expiry: Float;

	var ?domain: String;
	var ?path: String;
	var ?samesite: SameSite;

	/** makes this cookie only work on HTTPS **/
	var ?secure: Bool;

	/** makes JavaScript able to use this cookie. an alias for `HttpOnly` (flipped value) **/
	var ?js: Bool;

	/** temporary cookies that delete themselves after the client session is closed (ex: a browser closing)**/
	var ?session: Bool;

	/** only lets you use this cookie on the same exact domain you've set (no subdomains). an alias for `HostOnly` **/
	var ?strict: Bool;
}

@:forward
abstract Cookies(Map<String, Cookie>) {
	public function new(?map) {
		this = map ?? new Map();
	}

	// haxe likes to break forwarding for some reason
	inline public function get(name: String) {
		return this.get(name);
	}

	inline public function set(cookie: Cookie) {
		this.set(cookie.name, cookie);
	}

	static public function parse_plain(input: Array<String>) {
		var cookies = new Cookies();

		for(cookie in input) for(cookie in cookie.split(";")) {
			var key_value = cookie.split("=");

			var key: String = switch key_value[0] {
				case s if(s != null): StringTools.trim(s);
				case _: continue;
			}

			var value: String = switch key_value[1] {
				case s if(s != null): StringTools.trim(s);
				case _: continue;
			}

			cookies.set({
				name: key,
				value: value
			});
		}
		
		return cookies;
	}
}	