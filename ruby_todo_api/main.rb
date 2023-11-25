require "json"
require "sinatra/base"
require_relative "./app"
require_relative "./store"


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
                   resp[:todos] << { :id => id, :title => todo.title, :body => todo.body }
                end
                resp.to_json
            end

            post("/todos") do
                request.body.rewind
                data = JSON.parse request.body.read
                todo = app.add(data["title"], data["body"])
                { :id => todo.id, :title => todo.title, :body => todo.body }.to_json
            end

            get("/todos/:id") do
                todo = app.get_by_id(params["id"])

                if todo.nil?
                    status 404
                    return ""
                end

                { :id => todo.id, :title => todo.title, :body => todo.body }.to_json
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