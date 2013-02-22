$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'todo_txt_rb'

describe TodoTxt::Todo do
	describe '#priority' do
		it "returns the priority" do
			input = "(A) this is a test todo"
			expected = "A"
			subject = TodoTxt::Todo.new input
			subject.priority(input).should eq expected
		end

		it "returns an upper case priority" do
			input = "(a) this is a test todo"
			expected = "A"
			subject = TodoTxt::Todo.new input
			subject.priority(input).should eq expected
		end

		it "returns the first priority" do
			input = "(A) this is a test todo (b) (B)"
			expected = "A"
			subject = TodoTxt::Todo.new input
			subject.priority.should eq expected
		end
	end
	
	describe '#projects' do
		it "returns an array of projects" do
			input = "(A) this is a test todo +stuff +things +project"
			expected = ["+stuff", "+things", "+project"]
			subject = TodoTxt::Todo.new input
			subject.projects.should eq expected
		end			
	end	

	describe '#contexts' do
		it "returns an array of contexts" do
			input = "(A) this is a test todo @Concur @Work"
			expected = ["@Concur", "@Work"]
			subject = TodoTxt::Todo.new input
			subject.contexts.should eq expected
		end	
	end

	describe '#creation_date' do
		it "returns a date" do
			input = "(A) 2013-01-01 This is a test todo"
			expected = "2013-01-01"
			subject = TodoTxt::Todo.new input
			subject.creation_date.should eq expected
		end

		it "returns the date right after the priority" do
			input = "(A) 2013-01-01 2012-01-01 yaya todo 2010-01-01"
			expected  = "2013-01-01"
			subject = TodoTxt::Todo.new input
			subject.creation_date.should eq expected	
		end
	end

	describe '#remove_priority!' do
		it "removes the priority if there is one present" do
			input = "(A) this is a todo with a priority"
			expected = "this is a todo with a priority"
			subject = TodoTxt::Todo.new input
			subject.remove_priority!.should eq expected
		end	
	end

	describe '#change_priority!' do
		it "adds a priority if one does not exist" do
			input = "this todo has no priority."
			expected = "(A) this todo has no priority."
			subject = TodoTxt::Todo.new input
			subject.change_priority!("A").should eq expected
		end

		it "changes the priority if one exists" do
			input = "(A) this todo has a priority"
			expected = "(C) this todo has a priority"
			subject = TodoTxt::Todo.new input
			subject.change_priority!('C').should eq expected
		end	
	end
end