### prefer `len` to `default` 

```nim
# use len
let 
  a = ""
  b = @[]

assert a.len != 0
assert b.len != 0

# don't use
assert a != ""
assert b != ""
```

### prefer `plain functions` to `macros`

You can avoid `macros`. If necessary, you should only use simple ones.

```nim
macro resp*(response: Response) =
  ## handy to make ctx's response
  var ctx = ident"ctx"

  result = quote do:
    `ctx`.response = `response`
```
