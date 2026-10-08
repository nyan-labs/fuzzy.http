# fuzzy.http
> [!WARNING]
> this project is work-in-progress!!!

this is a http server for `sys` targets implemented via `sys.net.Socket`

| version | support | notes |
|-|-|-|
| http/0.9 | full | via a define `fuzzy.http.enable_http0_9` |
| http/1.0 | full | none |
| http/1.1 | partial | see [roadmap](#roadmap) section |
| http/2 | none | none |
| http/3 | none | unsure, needs lots more work as it uses QUIC |

# roadmap
* [ ] move everything not `fuzzy.http` out of this repo into their separate repos
* [ ] cookies
* [ ] cross origin resource sharing (cors)
* [ ] compresion
  * [ ] gzip 
  * [ ] brotli 
  * [ ] compress
  * [ ] deflate
* [ ] cache
  * [ ] e-tag
  * [ ] cache control 
* [ ] methods
  * [x] GET
  * [ ] PUT
  * [x] POST
  * [ ] DELETE
  * [ ] PATCH
  * [ ] HEAD
* [ ] ssl sockets (?)
* [ ] use hashlink-specific `hl.uv.Tcp` instead of `sys.net.Socket`

out of scope/to be moved:
* [ ] router
  * [ ] adding routes
  * [ ] middlware
  * [ ] static
* [ ] enum router
  * [x] adding routes (via an enum)
  * [ ] metadata macros (`@:param(var page: Int = 123)`)

# contributions
no ai contributions allowed

otherwise, feel free!