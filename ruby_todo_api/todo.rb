class Todo
    attr_reader :id
    attr_accessor :status, :title, :body

    def initialize(id, title, body)
        @id = id
        @title = title
        @body = body
    end
end
