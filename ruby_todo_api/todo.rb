class Todo
    attr_reader :id, :open
    attr_accessor :title, :body

    def initialize(id, title, body)
        @id = id
        @title = title
        @body = body
        open
    end

    def open
        @open = true
    end

    def close
        @open = false
    end

    def open?
        @open
    end
end
