package fuzzy.http;

enum abstract HeaderName(String) from String to String {  final Accept = 'Accept';
  final AcceptCH = 'Accept-CH';
  final AcceptEncoding = 'Accept-Encoding';
  final AcceptLanguage = 'Accept-Language';
  final AcceptPatch = 'Accept-Patch';
  final AcceptPost = 'Accept-Post';
  final AcceptQuery = 'Accept-Query';
  final AcceptRanges = 'Accept-Ranges';
  final AccessControlAllowCredentials = 'Access-Control-Allow-Credentials';
  final AccessControlAllowHeaders = 'Access-Control-Allow-Headers';
  final AccessControlAllowMethods = 'Access-Control-Allow-Methods';
  final AccessControlAllowOrigin = 'Access-Control-Allow-Origin';
  final AccessControlExposeHeaders = 'Access-Control-Expose-Headers';
  final AccessControlMaxAge = 'Access-Control-Max-Age';
  final AccessControlRequestHeaders = 'Access-Control-Request-Headers';
  final AccessControlRequestMethod = 'Access-Control-Request-Method';
  final ActivateStorageAccess = 'Activate-Storage-Access';
  final Age = 'Age';
  final Allow = 'Allow';
  final AltSvc = 'Alt-Svc';
  final AltUsed = 'Alt-Used';
  final AttributionReportingEligible = 'Attribution-Reporting-Eligible';
  final AttributionReportingRegisterSource = 'Attribution-Reporting-Register-Source';
  final AttributionReportingRegisterTrigger = 'Attribution-Reporting-Register-Trigger';
  final Authorization = 'Authorization';
  final AvailableDictionary = 'Available-Dictionary';
  final CacheControl = 'Cache-Control';
  final ClearSiteData = 'Clear-Site-Data';
  final Connection = 'Connection';
  final ContentDigest = 'Content-Digest';
  final ContentDisposition = 'Content-Disposition';
  final ContentDPR = 'Content-DPR';
  final ContentEncoding = 'Content-Encoding';
  final ContentLanguage = 'Content-Language';
  final ContentLength = 'Content-Length';
  final ContentLocation = 'Content-Location';
  final ContentRange = 'Content-Range';
  final ContentSecurityPolicy = 'Content-Security-Policy';
  final ContentSecurityPolicyReportOnly = 'Content-Security-Policy-Report-Only';
  final ContentType = 'Content-Type';
  final Cookie = 'Cookie';
  final CriticalCH = 'Critical-CH';
  final CrossOriginEmbedderPolicy = 'Cross-Origin-Embedder-Policy';
  final CrossOriginEmbedderPolicyReportOnly = 'Cross-Origin-Embedder-Policy-Report-Only';
  final CrossOriginOpenerPolicy = 'Cross-Origin-Opener-Policy';
  final CrossOriginResourcePolicy = 'Cross-Origin-Resource-Policy';
  final Date = 'Date';
  final DeviceMemory = 'Device-Memory';
  final DictionaryID = 'Dictionary-ID';
  final DNT = 'DNT';
  final Downlink = 'Downlink';
  final DPR = 'DPR';
  final EarlyData = 'Early-Data';
  final ECT = 'ECT';
  final ETag = 'ETag';
  final Expect = 'Expect';
  final ExpectCT = 'Expect-CT';
  final Expires = 'Expires';
  final Forwarded = 'Forwarded';
  final From = 'From';
  final Host = 'Host';
  final IdempotencyKey = 'Idempotency-Key';
  final IfMatch = 'If-Match';
  final IfModifiedSince = 'If-Modified-Since';
  final IfNoneMatch = 'If-None-Match';
  final IfRange = 'If-Range';
  final IfUnmodifiedSince = 'If-Unmodified-Since';
  final IntegrityPolicy = 'Integrity-Policy';
  final IntegrityPolicyReportOnly = 'Integrity-Policy-Report-Only';
  final KeepAlive = 'Keep-Alive';
  final LastModified = 'Last-Modified';
  final Link = 'Link';
  final Location = 'Location';
  final MaxForwards = 'Max-Forwards';
  final NEL = 'NEL';
  final NoVarySearch = 'No-Vary-Search';
  final ObserveBrowsingTopics = 'Observe-Browsing-Topics';
  final Origin = 'Origin';
  final OriginAgentCluster = 'Origin-Agent-Cluster';
  final PermissionsPolicy = 'Permissions-Policy';
  final PermissionsPolicyReportOnly = 'Permissions-Policy-Report-Only';
  final Pragma = 'Pragma';
  final Prefer = 'Prefer';
  final PreferenceApplied = 'Preference-Applied';
  final Priority = 'Priority';
  final ProxyAuthenticate = 'Proxy-Authenticate';
  final ProxyAuthorization = 'Proxy-Authorization';
  final Range = 'Range';
  final Referer = 'Referer';
  final ReferrerPolicy = 'Referrer-Policy';
  final Refresh = 'Refresh';
  final ReportTo = 'Report-To';
  final ReportingEndpoints = 'Reporting-Endpoints';
  final ReprDigest = 'Repr-Digest';
  final RetryAfter = 'Retry-After';
  final RTT = 'RTT';
  final SaveData = 'Save-Data';
  final SecBrowsingTopics = 'Sec-Browsing-Topics';
  final SecCHDeviceMemory = 'Sec-CH-Device-Memory';
  final SecCHDPR = 'Sec-CH-DPR';
  final SecCHPrefersColorScheme = 'Sec-CH-Prefers-Color-Scheme';
  final SecCHPrefersReducedMotion = 'Sec-CH-Prefers-Reduced-Motion';
  final SecCHPrefersReducedTransparency = 'Sec-CH-Prefers-Reduced-Transparency';
  final SecCHUA = 'Sec-CH-UA';
  final SecCHUAArch = 'Sec-CH-UA-Arch';
  final SecCHUABitness = 'Sec-CH-UA-Bitness';
  final SecCHUAFormFactors = 'Sec-CH-UA-Form-Factors';
  final SecCHUAFullVersion = 'Sec-CH-UA-Full-Version';
  final SecCHUAFullVersionList = 'Sec-CH-UA-Full-Version-List';
  final SecCHUAMobile = 'Sec-CH-UA-Mobile';
  final SecCHUAModel = 'Sec-CH-UA-Model';
  final SecCHUAPlatform = 'Sec-CH-UA-Platform';
  final SecCHUAPlatformVersion = 'Sec-CH-UA-Platform-Version';
  final SecCHUAWoW64 = 'Sec-CH-UA-WoW64';
  final SecCHViewportHeight = 'Sec-CH-Viewport-Height';
  final SecCHViewportWidth = 'Sec-CH-Viewport-Width';
  final SecCHWidth = 'Sec-CH-Width';
  final SecFetchDest = 'Sec-Fetch-Dest';
  final SecFetchMode = 'Sec-Fetch-Mode';
  final SecFetchSite = 'Sec-Fetch-Site';
  final SecFetchStorageAccess = 'Sec-Fetch-Storage-Access';
  final SecFetchUser = 'Sec-Fetch-User';
  final SecGPC = 'Sec-GPC';
  final SecPrivateStateToken = 'Sec-Private-State-Token';
  final SecPrivateStateTokenCryptoVersion = 'Sec-Private-State-Token-Crypto-Version';
  final SecPrivateStateTokenLifetime = 'Sec-Private-State-Token-Lifetime';
  final SecPurpose = 'Sec-Purpose';
  final SecRedemptionRecord = 'Sec-Redemption-Record';
  final SecSpeculationTags = 'Sec-Speculation-Tags';
  final SecWebSocketAccept = 'Sec-WebSocket-Accept';
  final SecWebSocketExtensions = 'Sec-WebSocket-Extensions';
  final SecWebSocketKey = 'Sec-WebSocket-Key';
  final SecWebSocketProtocol = 'Sec-WebSocket-Protocol';
  final SecWebSocketVersion = 'Sec-WebSocket-Version';
  final Server = 'Server';
  final ServerTiming = 'Server-Timing';
  final ServiceWorker = 'Service-Worker';
  final ServiceWorkerAllowed = 'Service-Worker-Allowed';
  final ServiceWorkerNavigationPreload = 'Service-Worker-Navigation-Preload';
  final SetCookie = 'Set-Cookie';
  final SetLogin = 'Set-Login';
  final SourceMap = 'SourceMap';
  final SpeculationRules = 'Speculation-Rules';
  final StrictTransportSecurity = 'Strict-Transport-Security';
  final SupportsLoadingMode = 'Supports-Loading-Mode';
  final TE = 'TE';
  final TimingAllowOrigin = 'Timing-Allow-Origin';
  final Tk = 'Tk';
  final Trailer = 'Trailer';
  final TransferEncoding = 'Transfer-Encoding';
  final Upgrade = 'Upgrade';
  final UpgradeInsecureRequests = 'Upgrade-Insecure-Requests';
  final UseAsDictionary = 'Use-As-Dictionary';
  final UserAgent = 'User-Agent';
  final Vary = 'Vary';
  final Via = 'Via';
  final ViewportWidth = 'Viewport-Width';
  final WantContentDigest = 'Want-Content-Digest';
  final WantReprDigest = 'Want-Repr-Digest';
  final Warning = 'Warning';
  final Width = 'Width';
  final WWWAuthenticate = 'WWW-Authenticate';
  final XContentTypeOptions = 'X-Content-Type-Options';
  final XDNSPrefetchControl = 'X-DNS-Prefetch-Control';
  final XForwardedFor = 'X-Forwarded-For';
  final XForwardedHost = 'X-Forwarded-Host';
  final XForwardedProto = 'X-Forwarded-Proto';
  final XFrameOptions = 'X-Frame-Options';
  final XPermittedCrossDomainPolicies = 'X-Permitted-Cross-Domain-Policies';
  final XPoweredBy = 'X-Powered-By';
  final XRobotsTag = 'X-Robots-Tag';
  final XXSSProtection = 'X-XSS-Protection';
}

@:forward
abstract Headers(Map<HeaderName, String>) {
  public function new(?map) {
    this = map ?? new Map();
  }

  @:to public function string() {
    var string = '';

    for(name => value in this) {
      string += '$name: $value\r\n'; // sanitization needed! i tink.
    }

    return string;
  }

  @:from static public function map(map: Map<HeaderName, String>) {
    return new Headers(map);
  }
}