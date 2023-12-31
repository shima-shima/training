require_relative './todo'
require 'securerandom'

class TodoFactory
    def new(title, body)
        Todo.new(SecureRandom.uuid, title, body)
    end
end

class InMemoryTodoRepository
    def initialize
        @todos = {}
    end

    def find_all
        @todos.dup
    end

    def find_by_id(id)
        @todos[id].dup
    end

    def save(todo)
        (@todos[todo.id] = todo).dup
    end
end
