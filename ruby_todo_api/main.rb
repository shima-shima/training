require "json"
require "sinatra/base"
require_relative "./app"
require_relative "./store"
require_relative "./todo"

class Todo
    def to_hash
        { :id => @id, :open => open?, :title => @title, :body => @body }
    end
end

class WebAPI
    def initialize(app)
        @server = server(app)
    end

    def run
        @server.run!
    end

    private

    def server(app)
        server = Sinatra.new {
            configure do
                set :port, 8080
            end

            before do
                content_type :json
            end

            get("/todos") do
                resp = { :todos => [] }
                app.get_all.each do |id, todo|
                    resp[:todos] << todo.to_hash
                end
                resp.to_json
            end

            post("/todos") do
                request.body.rewind
                data = JSON.parse request.body.read
                todo = app.add(data["title"], data["body"])
                todo.to_hash.to_json
            end

            get("/todos/:id") do
                todo = app.get_by_id(params["id"])

                if todo.nil?
                    status 404
                    return ""
                end

                todo.to_hash.to_json
            end
        }

        server
    end 
end

def run
    f = TodoFactory.new
    r = InMemoryTodoRepository.new
    app = TodoApp.new(f, r)
    WebAPI.new(app).run
end

run()