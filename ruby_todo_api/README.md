# Ruby Todo API
## Run server
```bash
$ ruby main.rb
# listen port: 8080
```

## Request examples
```bash
# get all todos
curl localhost:8080/todos

# create a todo
curl -X POST localhost:8080/todos \
-d 'title=hoge' \
-d 'body=fuga'

# get a todo
curl localhost:8080/todos/:id
```
