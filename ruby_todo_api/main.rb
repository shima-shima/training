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