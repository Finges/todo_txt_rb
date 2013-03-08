require 'fakefs/spec_helpers'
describe 'Todo_rb' do

	before(:each) do
			include FakeFS::SpecHelpers
			File.open(Dir.home.to_s + "/todo.txt", "w") do |f|
				f.puts "(A) This is a test todo 1"
				f.puts "(B) 2012-12-12 This test todo has a creation date" 
				f.puts "2011-11-11 this has a creation date no priority" 
				f.puts "This has a context @Car @Work @Phone" 
				f.puts "This has a project +work +programming +beer"
				f.puts "This has both Context and project +beer @car"
				f.puts "x this is a completed todo" 
				f.puts "x 2012-01-13 this is a completed todo with completion date +beer"	
			end
			`bin/todo_rb --init`	
		end

	describe 'list' do

		it "lists all todos" do
			expected = "1    (A) This is a test todo 1\n2    (B) 2012-12-12 This test todo has a creation date\n3    2011-11-11 this has a creation date no priority\n4    This has a context @Car @Work @Phone\n5    This has a project +work +programming +beer\n6    This has both Context and project +beer @car\n7    x this is a completed todo\n8    x 2012-01-13 this is a completed todo with completion date +beer\n"
			`bin/todo_rb list`.should eq expected
		end
		
	end

	describe 'add' do
		it "adds a todo" do
			expected = "1    (A) This is a test todo 1\n2    (B) 2012-12-12 This test todo has a creation date\n3    2011-11-11 this has a creation date no priority\n4    This has a context @Car @Work @Phone\n5    This has a project +work +programming +beer\n6    This has both Context and project +beer @car\n7    x this is a completed todo\n8    x 2012-01-13 this is a completed todo with completion date +beer\n9    testing an added todo\n"
			`bin/todo_rb add testing an added todo`
			`bin/todo_rb list`.should eq expected
		end
	end
	
	describe 'rm' do
		it "deletes a todo" do
			expected = "1    (B) 2012-12-12 This test todo has a creation date\n2    2011-11-11 this has a creation date no priority\n3    This has a context @Car @Work @Phone\n4    This has a project +work +programming +beer\n5    This has both Context and project +beer @car\n6    x this is a completed todo\n7    x 2012-01-13 this is a completed todo with completion date +beer\n"
			`bin/todo_rb rm 1`
			`bin/todo_rb list`.should eq expected	 
		end
	end

	describe 'do' do
		it "marks a todo complete" do
			expected = "1    (B) 2012-12-12 This test todo has a creation date\n2    2011-11-11 this has a creation date no priority\n3    This has a context @Car @Work @Phone\n4    This has a project +work +programming +beer\n5    This has both Context and project +beer @car\n6    x this is a completed todo\n7    x 2012-01-13 this is a completed todo with completion date +beer\n8    x #{Date.today.strftime("%F")} (A) This is a test todo 1\n"
			`bin/todo_rb do 1`
			`bin/todo_rb list`.should eq expected
		end
	end

	describe 'replace' do
		it "replaces a todo" do
			expected = "1    Replacement Todo\n2    (B) 2012-12-12 This test todo has a creation date\n3    2011-11-11 this has a creation date no priority\n4    This has a context @Car @Work @Phone\n5    This has a project +work +programming +beer\n6    This has both Context and project +beer @car\n7    x this is a completed todo\n8    x 2012-01-13 this is a completed todo with completion date +beer\n"
			`bin/todo_rb replace 1 Replacement Todo`
			`bin/todo_rb list`.should eq expected		
		end
	end

	describe 'listproj' do
		it "lists all projects" do
			expected = "+work, +programming, +beer\n"
			`bin/todo_rb listproj`.should eq expected
		end
	end

	describe 'listcontext' do
		it "lists all contexts" do
			expected = "@Car, @Work, @Phone\n"
			`bin/todo_rb listcontext`.should eq expected
		end
	end
end