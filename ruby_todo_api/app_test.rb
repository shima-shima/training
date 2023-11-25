require "minitest/autorun"
require_relative "./app"
require_relative "./store"
require_relative "./todo"
require "json"

describe TodoApp do

    describe "new" do
        it "ファクトリとリポジトリを指定して新規作成できる" do
            f = TodoFactory.new
            r = InMemoryTodoRepository.new
            TodoApp.new(f, r)
        end
    end

    describe "add" do
        f = TodoFactory.new
        r = InMemoryTodoRepository.new
        app = TodoApp.new(f, r)

        added_todo = app.add(:title, :body)

        it "addしたtodoのタイトルと返されたtodoのタイトルが一致する" do
            _(added_todo.title).must_equal :title
        end
        
        it "addしたtodoの内容と返されたtodoの内容が一致する" do
            _(added_todo.body).must_equal :body
        end
    end

    describe "add & get" do
        f = TodoFactory.new
        r = InMemoryTodoRepository.new
        app = TodoApp.new(f, r)
        
        add_todos = [
            { :title => "t1", :body => "b1"},
            { :title => "t2", :body => "b2"},
        ]

        actual_todos = app.get_all

        add_todos.each do |add_todo|
            app.add(add_todo[:title], add_todo[:body])
        end

        it "addした件数とget_allの件数が一致する" do
            _(actual_todos.length).must_equal add_todos.length
        end

        it "addしたtodoのタイトルとget_allしたtodoのタイトルが一致する" do
            actual_todos.each_with_index do |(id, actual_todo), i|
                _(actual_todo.title).must_equal add_todos[i][:title]
            end
        end

        it "addしたtodoの内容とget_allしたtodoの内容が一致する" do
            actual_todos.each_with_index do |(id, actual_todo), i|
                _(actual_todo.body).must_equal add_todos[i][:body]
            end
        end
    end
end