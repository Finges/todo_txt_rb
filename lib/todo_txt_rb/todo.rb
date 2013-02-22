module TodoTxt

	class Todo

		attr_accessor :todo

		def initialize(todo)
			@todo = todo
		end

		def priority todo=@todo  
			todo[/^\([a-zA-Z]\)/].gsub(/[()]/, "").upcase
		end
		
		def projects todo=@todo
			todo.scan(/\+\w+/)
		end	

		def contexts todo=@todo
			todo.scan(/@\w+/)
		end

		def creation_date todo=@todo
			@todo = todo.scan(/\d{4}-\d{2}-\d{2}/).fetch(0)
		end

		def remove_priority! todo=@todo
			@todo = todo.sub(/^\([A-Z]\)/,"").strip
		end

		def change_priority! priority, todo=@todo
			if todo.index(/^\([A-Z]\)/) == nil 
				@todo = "(#{priority}) " + todo
			else
				@todo = todo.sub(/^\([A-Z]\)/, "(#{priority})")
			end	
		end
	end
end