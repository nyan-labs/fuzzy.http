package fuzzy.http;

enum abstract SameSite(String) {
	final STRICT = "strict";
	final LAX = "lax";
	final none = "none";
}

typedef Cookie = {
	final name: String;

	var value: String;
	var expiry: Float;

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

	inline public function set(cookie: Cookie) {
		this.set(cookie.name, cookie);
	}
}	