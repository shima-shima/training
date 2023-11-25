# Ruby Todo API
## Server run
```bash
$ ruby main.rb
# listen port: 8080
```

## Examples
```bash
# get all todos
curl localhost:8080/todos

# create a todo
curl -X POST localhost:8080/todos -d '{ "title": "hoge", "body": "fuga" }'

# get a todo
curl localhost:8080/todos/:id
```
