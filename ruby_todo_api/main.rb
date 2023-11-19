require "webrick"
require "json"
require_relative "./app"
require_relative "./store"


class WebAPI
    def initialize
        @app = app
        @server = server
    end

    def run
        trap("INT") do @server.shutdown end
        @server.start
    end

    private
    def app
        f = TodoFactory.new
        r = InMemoryTodoRepository.new
        app = TodoApp.new(f, r)
    end

    def server
        server = WEBrick::HTTPServer.new({ Port: 8080 })

        content_type = "application/json"
        response = { "todos" => [] }

        server.mount_proc "/todos" do |req, res|
            res["Content-Type"] = content_type
            response["todos"] = @app.get_all.to_a
            res.body = response.to_json
        end

        server
    end
end

def run
    WebAPI.new.run
end

run()