![Build Status](https://github.com/planety/prologue/workflows/Test%20Prologue/badge.svg)
[![Build Status](https://dev.azure.com/xzsflywind/xlsx/_apis/build/status/planety.prologue?branchName=master)](https://dev.azure.com/xzsflywind/xlsx/_build/latest?definitionId=4&branchName=master)
![Build Status](https://travis-ci.org/planety/prologue.svg?branch=master)

![License: Apache-2.0](https://img.shields.io/github/license/planety/prologue)
[![Version](https://img.shields.io/github/v/release/planety/prologue?include_prereleases)](https://github.com/planety/prologue/releases)
[![buy me a coffee](https://img.shields.io/badge/donate-buy%20me%20a%20coffee-orange.svg)](https://github.com/planety/prologue#donate)
[![Discord](https://img.shields.io/discord/718010516034945045?label=Discord&logo=discord&logoColor=white)](https://discord.gg/e2dB4WT)

# Prologue

What's past is prologue.

## Purpose
Prologue is a Full-Stack Web Framework which is
ideal for building elegant and high performance
web services.

**Reduce magic. Reduce surprise.**

## Documentation

You can read documentation in https://planety.github.io/prologue.

Core API docs in https://planety.github.io/prologue/coreapi/theindex.html.

Plugin API docs in https://planety.github.io/prologue/plugin/theindex.html.

## Feature

- Core
  - [x] Base on httpx and asynchttpserver
  - [x] Configure and Settings
  - [x] Context
  - [x] Param and Query Data
  - [x] Form Data
  - [x] Static Files
  - [x] Middleware
  - [x] Simple Route
  - [x] Regex Route
  - [x] DSL Route
  - [x] CORS Response
  - [x] Signing
  - [x] Cookie
  - [x] Session
  - [x] Cache
  - [x] Startup and Shutdown Events
  - [x] URL Building
  - [x] Data Validation
  - [x] Exception Handler
  - [x] Cross-Site Request Forgery
  - [x] Cross-Site Scripting (XSS) Protection(Karax quote string automatically)
  - [x] Clickjacking Protection
  - [x] Authentication
  - [x] I18n

- Plugin
  - [x] Minimal OpenApi support
  - [x] Template(Using Karax Native)
  - [x] Websocket support(https://github.com/xflywind/websocketx)
  - [x] Test Client(Using httpclient)
  - [x] Command line tools(https://github.com/planety/logue)

## Installation

First you should install [Nim](https://nim-lang.org/) language which is an elegant and high performance language. Follow the [instructions](https://nim-lang.org/install.html) and set environment variables correctly.

Then you can use `nimble` command to install prologue.

```bash
nimble install prologue
```

## Usage

### Notes(important)

1. If you use Linux or MacOS, you can use `--threads:on` to enable the multi-threads HTTP server.

2. If you use windows and want to use multi-threads HTTP server, make sure use
latest Nim devel version and enable `--threads:on`. In this situation, you can
use `-d:usestd` to use `asynchttpserver`.

3. Notes that multi-threads may be slower than single-thread!

4. If you want to benchmark `prologue` or release you programs, make sure set `settings.debug` = false.

```nim
let
  # debug attributes must be false
  env = loadPrologueEnv(".env")
  settings = newSettings(appName = env.getOrDefault("appName", "Prologue"),
                         debug = false,
                         port = Port(env.getOrDefault("port", 8787)),
                         staticDirs = [env.get("staticDir")],
                         secretKey = env.getOrDefault("secretKey", "")
    )
```

or in `.env` file, set `debug = false`.

```nim
# Don't commit this to source control.
# Eg. Make sure ".env" in your ".gitignore" file.
debug=false # change this
port=8787
appName=HelloWorld
staticDir=/static
secretKey=Pr435ol67ogue
```

There are two ways to disable logging messages:

(1) set `settings.debug` = false
(2) set a startup event

```nim
proc setLoggingLevel() =
  addHandler(newConsoleLogger())
  logging.setLogFilter(lvlInfo)


let 
  event = initEvent(setLoggingLevel)
var
  app = newApp(settings = settings, middlewares = @[debugRequestMiddleware()], startup = @[event])
```

### Hello World

```nim
# app.nim
import prologue


proc hello*(ctx: Context) {.async.} =
  resp "<h1>Hello, Prologue!</h1>"


let settings = newSettings()
var app = newApp(settings = settings)
app.addRoute("/", hello)
app.run()
```

Run **app.nim**. Now the server is running at localhost:8080.

### Another example

```nim
# app.nim
import prologue
import prologue/middlewares


# Async Function
proc home*(ctx: Context) {.async.} =
  resp "<h1>Home</h1>"

proc helloName*(ctx: Context) {.async.} =
  resp "<h1>Hello, " & ctx.getPathParams("name", "Prologue") & "</h1>"

proc doRedirect*(ctx: Context) {.async.} =
  resp redirect("/hello")

proc login*(ctx: Context) {.async.} =
  resp loginPage()

proc do_login*(ctx: Context) {.async.} =
  resp redirect("/hello/Nim")


let settings = newSettings(appName = "StarLight")
var app = newApp(settings = settings, middlewares = @[debugRequestMiddleware()])
app.addRoute("/", home, @[HttpGet, HttpPost])
app.addRoute("/home", home, HttpGet)
app.addRoute("/redirect", doRedirect, HttpGet)
app.addRoute("/login", login, HttpGet)
app.addRoute("/login", do_login, HttpPost, middlewares = @[debugRequestMiddleware()])
app.addRoute("/hello/{name}", helloName, HttpGet)
app.run()
```

Run **app.nim**. Now the server is running at localhost:8080.

#### DSL for routes  

You can read docs in https://nim-lang.github.io/Nim/with.html and construct your own DSL.

Pseudocode:

```nim
import std/with


with app:
  get "/", home
  post "/", home
  get "/home", home
  get "/home", home
  get "/redirect", doRedirect
  get "/login", login  
  post("/login", login, middlewares = debugRequestMiddleware())
  get "/hello/{name}", helloName
  addRoute [HttpGet, HttpPost], helloRoute
```

Run **app.nim**. Now the server is running at localhost:8080.

### More examples
- [HelloWorld](https://github.com/planety/prologue/tree/master/examples/helloworld)
- [ToDoList](https://github.com/planety/prologue/tree/master/examples/todolist)
- [ToDoApp](https://github.com/planety/prologue/tree/master/examples/todoapp)
- [Blog](https://github.com/planety/prologue/tree/master/examples/blog)

### Extensions

If you need more extensions, you can refer to [awesome prologue](https://github.com/planety/awesome-prologue) and [awesome nim](https://github.com/xflywind/awesome-nim#web).


### Donate

Thanks for supporting me!

[buy me a coffee](https://www.buymeacoffee.com/flywind)

[patreon](https://www.patreon.com/flywind)


### Stars
[![Stargazers over time](https://starchart.cc/planety/prologue.svg)](https://starchart.cc/planety/prologue)
