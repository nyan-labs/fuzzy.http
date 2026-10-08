package fuzzy.http;

import haxe.Json;

using Std;

enum abstract Status(Int) from Int to Int {
	final Continue = 100;
	final SwitchingProtocols = 101;
	final EarlyHints = 103;
	final OK = 200;
	final Created = 201;
	final Accepted = 202;
	final NonAuthoritativeInformation = 203;
	final NoContent = 204;
	final ResetContent = 205;
	final PartialContent = 206;
	final MultiStatus = 207;
	final AlreadyReported = 208;
	final IMUsed = 226;
	final MultipleChoices = 300;
	final MovedPermanently = 301;
	final Found = 302;
	final SeeOther = 303;
	final NotModified = 304;
	final TemporaryRedirect = 307;
	final PermanentRedirect = 308;
	final BadRequest = 400;
	final Unauthorized = 401;
	final PaymentRequired = 402;
	final Forbidden = 403;
	final NotFound = 404;
	final MethodNotAllowed = 405;
	final NotAcceptable = 406;
	final ProxyAuthenticationRequired = 407;
	final RequestTimeout = 408;
	final Conflict = 409;
	final Gone = 410;
	final LengthRequired = 411;
	final PreconditionFailed = 412;
	final ContentTooLarge = 413;
	final URITooLong = 414;
	final UnsupportedMediaType = 415;
	final RangeNotSatisfiable = 416;
	final ExpectationFailed = 417;
	final Imateapot = 418;
	final MisdirectedRequest = 421;
	final UnprocessableContent = 422;
	final Locked = 423;
	final FailedDependency = 424;
	final TooEarly = 425;
	final UpgradeRequired = 426;
	final PreconditionRequired = 428;
	final TooManyRequests = 429;
	final RequestHeaderFieldsTooLarge = 431;
	final UnavailableForLegalReasons = 451;
	final InternalServerError = 500;
	final NotImplemented = 501;
	final BadGateway = 502;
	final ServiceUnavailable = 503;
	final GatewayTimeout = 504;
	final HTTPVersionNotSupported = 505;
	final VariantAlsoNegotiates = 506;
	final InsufficientStorage = 507;
	final LoopDetected = 508;
	final NotExtended = 510;
	final NetworkAuthenticationRequired = 511;
}

@:struct
@:structInit
@:publicFields
class ResponseData {
	var body: String = null;
	var status: Status = OK;
	
	var headers: Headers = new Headers();
}

@:forward
abstract Response(ResponseData) {
	@:from public function new(?data: ResponseData) {
		this = data ?? {};
	}

	@:from static function from_string(s: String): Response {
		return text(OK, s);
	}

	static public function text(status: Status, text: String): Response {
		return new Response({
			status: status,
			body: text,
			headers: Headers.map([
				ContentLength => text.length.string()
			])
		});
	}

	static public function json(status: Status, data: Dynamic) {
		// todo: faster/better json parser
		var json = Json.stringify(data);

		return new Response({
			status: status,
			headers: Headers.map([
				ContentLength => json.length.string(),
				ContentType => "application/json"
			]),
			body: json
		});
	}
} 