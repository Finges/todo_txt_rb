$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'todo_txt_rb'
require 'fakefs/spec_helpers'

describe TodoTxt::List do
	before(:each) do
		include FakeFS::SpecHelpers
		File.open("todo.txt", "w") do |f|
			f.puts "(A) This is a test todo 1"
			f.puts "(B) 2012-12-12 This test todo has a creation date" 
			f.puts "2011-11-11 this has a creation date no priority" 
			f.puts "This has a context @car @work @phone" 
			f.puts "This has a project +work +programming +beer"
			f.puts "(C) This has both Context and project +beer @car"
			f.puts "x this is a completed todo" 
			f.puts "x 2012-01-13 this is a completed todo with completion date +beer"	
		end
	end

	describe "#list" do
		it "returns an array of all Todos" do
			expected = ["(A) This is a test todo 1\n", "(B) 2012-12-12 This test todo has a creation date\n", "2011-11-11 this has a creation date no priority\n", "This has a context @car @work @phone\n", "This has a project +work +programming +beer\n", "(C) This has both Context and project +beer @car\n", "x this is a completed todo\n", "x 2012-01-13 this is a completed todo with completion date +beer\n"]
			subject = TodoTxt::List.new "todo.txt"
			subject.list.should eq expected
		end	
	end	
	describe "#add_todo" do
		it "adds a todo" do
			subject = TodoTxt::List.new "todo.txt"
			subject.add_todo("This is an additional todo")
			IO.readlines("todo.txt").size.should eq 9 
		end
	end
	describe "#remove_todo" do	
		it "removes a todo" do 
			subject = TodoTxt::List.new "todo.txt"
			subject.remove_todo(2)
			IO.readlines("todo.txt").size.should eq 7 
		end

		it "removes specified todo" do
			expected = ["(A) This is a test todo 1\n", "2011-11-11 this has a creation date no priority\n", "This has a context @car @work @phone\n", "This has a project +work +programming +beer\n", "(C) This has both Context and project +beer @car\n", "x this is a completed todo\n", "x 2012-01-13 this is a completed todo with completion date +beer\n"]
			subject = TodoTxt::List.new "todo.txt"
			subject.remove_todo(2)
			subject.list.should eq expected
		end
	end

	describe "#edit_todo" do 
		it "replaces a todo" do
			subject = TodoTxt::List.new "todo.txt"
			subject.edit_todo(2, "This is a new edited todo")
			subject.list.size.should eq 8	
		end 

		it "overwrites a todo" do
			expected = ["(A) This is a test todo 1\n", "This is a new edited todo\n", "2011-11-11 this has a creation date no priority\n", "This has a context @car @work @phone\n", "This has a project +work +programming +beer\n", "(C) This has both Context and project +beer @car\n", "x this is a completed todo\n", "x 2012-01-13 this is a completed todo with completion date +beer\n"]
			subject = TodoTxt::List.new "todo.txt"
			subject.edit_todo(2, "This is a new edited todo")
			subject.list.should eq expected
		end
	end

	describe '#list_active' do
		it "returns an array of active todos" do
			expected = ["(A) This is a test todo 1\n", "(B) 2012-12-12 This test todo has a creation date\n", "2011-11-11 this has a creation date no priority\n", "This has a context @car @work @phone\n", "This has a project +work +programming +beer\n", "(C) This has both Context and project +beer @car\n"]
			subject = TodoTxt::List.new "todo.txt"
			subject.list_active.size.should eq 6 
		end
	end

	describe "#list_projects" do 
		it "returns an array of unique project tags" do
			expected = ["+work", "+programming", "+beer"]
			subject = TodoTxt::List.new "todo.txt"
			subject.list_projects.should eq expected
		end
	end

	describe "#list_contexts" do 
		it "returns an array of unique context tags" do
			expected = ["@car", "@work", "@phone"]
			subject = TodoTxt::List.new "todo.txt"
			subject.list_contexts.should eq expected
		end
	end

	describe "#get_projects" do 
		it "returns an array of all todos with project" do
			expected = ["This has a project +work +programming +beer\n", "(C) This has both Context and project +beer @car\n"]
			subject = TodoTxt::List.new "todo.txt"
			subject.get_projects("+beer").should eq expected
		end
	end

	describe "#get_contexts" do 
		it "returns an array of all todos with context" do
			expected = ["This has a context @car @work @phone\n", "(C) This has both Context and project +beer @car\n"]
			subject = TodoTxt::List.new "todo.txt"
			subject.get_contexts("@car").should eq expected
		end
	end

	describe "#complete_todo" do 
		it "marks a todo completed" do
			expected = ["(B) 2012-12-12 This test todo has a creation date\n", "2011-11-11 this has a creation date no priority\n", "This has a context @car @work @phone\n", "This has a project +work +programming +beer\n", "(C) This has both Context and project +beer @car\n", "x this is a completed todo\n", "x 2012-01-13 this is a completed todo with completion date +beer\n", "x #{Date.today.strftime("%F")} (A) This is a test todo 1\n"]
			subject = TodoTxt::List.new "todo.txt"
			subject.complete_todo(1)
			subject.list.should eq expected
		end
	end

	describe '#order_by_priority' do
		it "returns an array" do
			subject = TodoTxt::List.new "todo.txt"
			subject.order_by_priority.class.should eq Array
		end

		it "returns an array of todo objects" do
			subject = TodoTxt::List.new "todo.txt"
			subject.order_by_priority[1].class.should eq TodoTxt::Todo
		end

		it "orders the todo list by priority" do
			expected = ["(A) This is a test todo 1\n", "(B) 2012-12-12 This test todo has a creation date\n", "(C) This has both Context and project +beer @car\n", "This has a project +work +programming +beer\n", "This has a context @car @work @phone\n", "2011-11-11 this has a creation date no priority\n", "x this is a completed todo\n", "x 2012-01-13 this is a completed todo with completion date +beer\n"]
			subject = TodoTxt::List.new "todo.txt"
			subject.order_by_priority.collect{|x| x.todo}.should eq expected
		end

		
	end

	describe "#get_todo_index" do
		it "returns the matchin todo's index" do
			expected = 1
			input = "(B) 2012-12-12 This test todo has a creation date"
			subject = TodoTxt::List.new "todo.txt"
			subject.get_todo_index(input).should eq expected 
		end
	end
end