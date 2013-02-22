module TodoTxt

	class List < Array
		def initialize(file)
			@todo_list = file
			@list = File.readlines(file).map{ |x| TodoTxt::Todo.new(x)}
		end
		
		def write_file
			File.open(@todo_list, 'w') do |f|
				@list.each{|x| f.puts x.to_s}
			end
		end

		def list
			@list.collect{|x| x.todo}
		end

		def add_todo new_todo
			File.open(@todo_list, "a"){|f| f.puts new_todo }
		end

		def remove_todo todo_num
			@list.delete_at(todo_num - 1)
			self.write_file		
		end

		def edit_todo todo_num, new_todo
			@list[todo_num - 1] = TodoTxt::Todo.new(new_todo + "\n")
			self.write_file
		end
	end
	
end