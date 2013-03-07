require_relative "todo_txt_rb/version"
require_relative "todo_txt_rb/todo"
require_relative "todo_txt_rb/list"
require 'yaml'


module TodoTxt
	def print_todo_list list
		list.list.each_with_index{|todo, index| puts "#{index + 1}    #{todo}"}
	end	

	def self.init_config 
		default_config = {'todo_file_location' => Dir.home.to_s + '/todo.txt'}
		File.open(Dir.home.to_s + '/.todocfg.yml', "w") do |file|
			file.write("# todo_file_location should be set to the location of your todo.txt\n")
			file.write(default_config.to_yaml)
		end
	end
end