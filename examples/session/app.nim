import ../../src/prologue
import ../../src/prologue/middlewares
import ./urls

let
  env = loadPrologueEnv(".env")
  secretKey = env.getOrDefault("secretKey", "")
  settings = newSettings(appName = env.getOrDefault("appName", "Prologue"),
                         debug = env.getOrDefault("debug", true),
                         port = Port(env.getOrDefault("port", 8080)),
                         staticDirs = [env.get("staticDir")],
                         secretKey = secretKey
    )


var app = newApp(settings = settings, middlewares = @[debugRequestMiddleware(), sessionMiddleware(secretKey = secretKey.SecretKey)])
app.addRoute(urls.urlPatterns, "")
app.run()
