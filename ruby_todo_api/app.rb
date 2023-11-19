require_relative "./todo"

class TodoApp
    def initialize(factory, repository)
        @factory = factory
        @repository = repository
    end

    def get_all
        @repository.find_all
    end

    def add(title, body)
        @repository.save(@factory.new(title, body))
    end
end
