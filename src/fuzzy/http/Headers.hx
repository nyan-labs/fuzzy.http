package fuzzy.http;

enum abstract HeaderName(String) from String to String {  
  final Accept = 'accept';
  final AcceptCH = 'accept-ch';
  final AcceptEncoding = 'accept-encoding';
  final AcceptLanguage = 'accept-language';
  final AcceptPatch = 'accept-patch';
  final AcceptPost = 'accept-post';
  final AcceptQuery = 'accept-query';
  final AcceptRanges = 'accept-ranges';
  final AccessControlAllowCredentials = 'access-control-allow-credentials';
  final AccessControlAllowHeaders = 'access-control-allow-headers';
  final AccessControlAllowMethods = 'access-control-allow-methods';
  final AccessControlAllowOrigin = 'access-control-allow-origin';
  final AccessControlExposeHeaders = 'access-control-expose-headers';
  final AccessControlMaxAge = 'access-control-max-age';
  final AccessControlRequestHeaders = 'access-control-request-headers';
  final AccessControlRequestMethod = 'access-control-request-method';
  final ActivateStorageAccess = 'activate-storage-access';
  final Age = 'age';
  final Allow = 'allow';
  final AltSvc = 'alt-svc';
  final AltUsed = 'alt-used';
  final AttributionReportingEligible = 'attribution-reporting-eligible';
  final AttributionReportingRegisterSource = 'attribution-reporting-register-source';
  final AttributionReportingRegisterTrigger = 'attribution-reporting-register-trigger';
  final Authorization = 'authorization';
  final AvailableDictionary = 'available-dictionary';
  final CacheControl = 'cache-control';
  final ClearSiteData = 'clear-site-data';
  final Connection = 'connection';
  final ContentDigest = 'content-digest';
  final ContentDisposition = 'content-disposition';
  final ContentDPR = 'content-dpr';
  final ContentEncoding = 'content-encoding';
  final ContentLanguage = 'content-language';
  final ContentLength = 'content-length';
  final ContentLocation = 'content-location';
  final ContentRange = 'content-range';
  final ContentSecurityPolicy = 'content-security-policy';
  final ContentSecurityPolicyReportOnly = 'content-security-policy-report-only';
  final ContentType = 'content-type';
  final Cookie = 'cookie';
  final CriticalCH = 'critical-ch';
  final CrossOriginEmbedderPolicy = 'cross-origin-embedder-policy';
  final CrossOriginEmbedderPolicyReportOnly = 'cross-origin-embedder-policy-report-only';
  final CrossOriginOpenerPolicy = 'cross-origin-opener-policy';
  final CrossOriginResourcePolicy = 'cross-origin-resource-policy';
  final Date = 'date';
  final DeviceMemory = 'device-memory';
  final DictionaryID = 'dictionary-id';
  final DNT = 'dnt';
  final Downlink = 'downlink';
  final DPR = 'dpr';
  final EarlyData = 'early-data';
  final ECT = 'ect';
  final ETag = 'etag';
  final Expect = 'expect';
  final ExpectCT = 'expect-ct';
  final Expires = 'expires';
  final Forwarded = 'forwarded';
  final From = 'from';
  final Host = 'host';
  final IdempotencyKey = 'idempotency-key';
  final IfMatch = 'if-match';
  final IfModifiedSince = 'if-modified-since';
  final IfNoneMatch = 'if-none-match';
  final IfRange = 'if-range';
  final IfUnmodifiedSince = 'if-unmodified-since';
  final IntegrityPolicy = 'integrity-policy';
  final IntegrityPolicyReportOnly = 'integrity-policy-report-only';
  final KeepAlive = 'keep-alive';
  final LastModified = 'last-modified';
  final Link = 'link';
  final Location = 'location';
  final MaxForwards = 'max-forwards';
  final NEL = 'nel';
  final NoVarySearch = 'no-vary-search';
  final ObserveBrowsingTopics = 'observe-browsing-topics';
  final Origin = 'origin';
  final OriginAgentCluster = 'origin-agent-cluster';
  final PermissionsPolicy = 'permissions-policy';
  final PermissionsPolicyReportOnly = 'permissions-policy-report-only';
  final Pragma = 'pragma';
  final Prefer = 'prefer';
  final PreferenceApplied = 'preference-applied';
  final Priority = 'priority';
  final ProxyAuthenticate = 'proxy-authenticate';
  final ProxyAuthorization = 'proxy-authorization';
  final Range = 'range';
  final Referer = 'referer';
  final ReferrerPolicy = 'referrer-policy';
  final Refresh = 'refresh';
  final ReportTo = 'report-to';
  final ReportingEndpoints = 'reporting-endpoints';
  final ReprDigest = 'repr-digest';
  final RetryAfter = 'retry-after';
  final RTT = 'rtt';
  final SaveData = 'save-data';
  final SecBrowsingTopics = 'sec-browsing-topics';
  final SecCHDeviceMemory = 'sec-ch-device-memory';
  final SecCHDPR = 'sec-ch-dpr';
  final SecCHPrefersColorScheme = 'sec-ch-prefers-color-scheme';
  final SecCHPrefersReducedMotion = 'sec-ch-prefers-reduced-motion';
  final SecCHPrefersReducedTransparency = 'sec-ch-prefers-reduced-transparency';
  final SecCHUA = 'sec-ch-ua';
  final SecCHUAArch = 'sec-ch-ua-arch';
  final SecCHUABitness = 'sec-ch-ua-bitness';
  final SecCHUAFormFactors = 'sec-ch-ua-form-factors';
  final SecCHUAFullVersion = 'sec-ch-ua-full-version';
  final SecCHUAFullVersionList = 'sec-ch-ua-full-version-list';
  final SecCHUAMobile = 'sec-ch-ua-mobile';
  final SecCHUAModel = 'sec-ch-ua-model';
  final SecCHUAPlatform = 'sec-ch-ua-platform';
  final SecCHUAPlatformVersion = 'sec-ch-ua-platform-version';
  final SecCHUAWoW64 = 'sec-ch-ua-wow64';
  final SecCHViewportHeight = 'sec-ch-viewport-height';
  final SecCHViewportWidth = 'sec-ch-viewport-width';
  final SecCHWidth = 'sec-ch-width';
  final SecFetchDest = 'sec-fetch-dest';
  final SecFetchMode = 'sec-fetch-mode';
  final SecFetchSite = 'sec-fetch-site';
  final SecFetchStorageAccess = 'sec-fetch-storage-access';
  final SecFetchUser = 'sec-fetch-user';
  final SecGPC = 'sec-gpc';
  final SecPrivateStateToken = 'sec-private-state-token';
  final SecPrivateStateTokenCryptoVersion = 'sec-private-state-token-crypto-version';
  final SecPrivateStateTokenLifetime = 'sec-private-state-token-lifetime';
  final SecPurpose = 'sec-purpose';
  final SecRedemptionRecord = 'sec-redemption-record';
  final SecSpeculationTags = 'sec-speculation-tags';
  final SecWebSocketAccept = 'sec-websocket-accept';
  final SecWebSocketExtensions = 'sec-websocket-extensions';
  final SecWebSocketKey = 'sec-websocket-key';
  final SecWebSocketProtocol = 'sec-websocket-protocol';
  final SecWebSocketVersion = 'sec-websocket-version';
  final Server = 'server';
  final ServerTiming = 'server-timing';
  final ServiceWorker = 'service-worker';
  final ServiceWorkerAllowed = 'service-worker-allowed';
  final ServiceWorkerNavigationPreload = 'service-worker-navigation-preload';
  final SetCookie = 'set-cookie';
  final SetLogin = 'set-login';
  final SourceMap = 'sourcemap';
  final SpeculationRules = 'speculation-rules';
  final StrictTransportSecurity = 'strict-transport-security';
  final SupportsLoadingMode = 'supports-loading-mode';
  final TE = 'te';
  final TimingAllowOrigin = 'timing-allow-origin';
  final Tk = 'tk';
  final Trailer = 'trailer';
  final TransferEncoding = 'transfer-encoding';
  final Upgrade = 'upgrade';
  final UpgradeInsecureRequests = 'upgrade-insecure-requests';
  final UseAsDictionary = 'use-as-dictionary';
  final UserAgent = 'user-agent';
  final Vary = 'vary';
  final Via = 'via';
  final ViewportWidth = 'viewport-width';
  final WantContentDigest = 'want-content-digest';
  final WantReprDigest = 'want-repr-digest';
  final Warning = 'warning';
  final Width = 'width';
  final WWWAuthenticate = 'www-authenticate';
  final XContentTypeOptions = 'x-content-type-options';
  final XDNSPrefetchControl = 'x-dns-prefetch-control';
  final XForwardedFor = 'x-forwarded-for';
  final XForwardedHost = 'x-forwarded-host';
  final XForwardedProto = 'x-forwarded-proto';
  final XFrameOptions = 'x-frame-options';
  final XPermittedCrossDomainPolicies = 'x-permitted-cross-domain-policies';
  final XPoweredBy = 'x-powered-by';
  final XRobotsTag = 'x-robots-tag';
  final XXSSProtection = 'x-xss-protection';
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