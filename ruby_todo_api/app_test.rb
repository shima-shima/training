require "minitest/autorun"
require_relative "./app"
require_relative "./store"
require_relative "./todo"

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

        added_todo = app.add(:title, :body)

        it "addしたtodoのタイトルとgetしたtodoのタイトルが一致する" do
            _(app.get_by_id(added_todo.id).title).must_equal :title
        end

        it "addしたtodoの内容とgetしたtodoの内容が一致する" do
            _(app.get_by_id(added_todo.id).body).must_equal :body
        end
    end

    describe "add & get_all" do
        f = TodoFactory.new
        r = InMemoryTodoRepository.new
        app = TodoApp.new(f, r)
        
        add_todos = [
            { :title => "t1", :body => "b1"},
            { :title => "t2", :body => "b2"},
        ]

        add_todos.each do |add_todo|
            app.add(add_todo[:title], add_todo[:body])
        end

        actual_todos = app.get_all

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

    describe "update" do
        f = TodoFactory.new
        r = InMemoryTodoRepository.new
        app = TodoApp.new(f, r)

        added_todo = app.add(:title, :body)

        update_todo = added_todo
        update_todo.title = "update: #{added_todo.title}"
        update_todo.body = "update: #{added_todo.body}"
        updated_todo = app.update(update_todo)

        it "updateしたtodoのタイトルと返されたtodoのタイトルが一致する" do
            _(updated_todo.title).must_equal update_todo.title
        end
        
        it "updateしたtodoの内容と返されたtodoの内容が一致する" do
            _(updated_todo.body).must_equal update_todo.body
        end

        it "存在しないtodoをupdateするとnilが返ってくる" do
            _(app.update(Todo.new("", "", ""))).must_be_nil
        end
    end

    describe "update & get" do
        f = TodoFactory.new
        r = InMemoryTodoRepository.new
        app = TodoApp.new(f, r)

        added_todo = app.add(:title, :body)

        update_todo = added_todo
        update_todo.title = "update: #{added_todo.title}"
        update_todo.body = "update: #{added_todo.body}"
        app.update(update_todo)

        updated_todo = app.get_by_id(added_todo.id)

        it "updateしたtodoのタイトルと返されたtodoのタイトルが一致する" do
            _(updated_todo.title).must_equal update_todo.title
        end
        
        it "updateしたtodoの内容と返されたtodoの内容が一致する" do
            _(updated_todo.body).must_equal update_todo.body
        end
    end
end