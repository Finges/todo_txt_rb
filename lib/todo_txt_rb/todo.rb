module TodoTxt

	class Todo 

		attr_accessor :todo

		def initialize(todo)
			@todo = todo
		end

		def priority todo=@todo  
			priority = todo[/^\([a-zA-Z]\)/]
			if priority == nil
				return false 
			else
				priority.gsub(/[()]/, "").upcase
			end
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

		def is_complete? todo=@todo
			if todo.index(/^x/) == nil
				false
			else
				true
			end
		end	

		def is_active? todo=@todo
			if todo.index(/^x/) == nil
				true
			else
				false
			end
		end

		def mark_complete! todo=@todo
			@todo = "x #{Date.today.strftime("%F")} " + @todo 
			
		end
	end
end