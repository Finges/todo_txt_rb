module TodoTxt

	class List < Array
		def initialize(file)
			@todo_list = file
			@list = File.readlines(file).map{ |x| TodoTxt::Todo.new(x)}
		end
		
		def write_file
			File.open(@todo_list, 'w') do |f|
				@list.each{|x| f.puts x.todo.to_s}
			end
		end

		def list
			@list.collect{|x| x.todo}
		end

		def list_active
			@list.select{|x| x.is_active?}
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

		def list_projects
			@list.collect{|x| x.projects}.flatten.uniq{|x| x.downcase}
		end

		def list_contexts
			@list.collect{|x| x.contexts}.flatten.uniq{|x| x.capitalize}
		end

		def get_projects project
			self.list_active.select{|x| x.todo.include?(project)}.map{|x| x.todo}
		end

		def get_contexts context
			self.list_active.select{|x| x.todo.include?(context)}.map{|x| x.todo}
		end

		def complete_todo todo_num
			@list[todo_num - 1].mark_complete!
			@list << @list[todo_num - 1]
			@list.delete_at(todo_num - 1)
			self.write_file
		end

		def get_todo_index todo_text
			@list.index{|x| x.todo.chomp.eql?(todo_text.chomp)}
		end

		def order_by_priority 
			@list.sort{|x,y| x.priority.to_s <=> y.priority.to_s}
		end
	end
end