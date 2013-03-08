# TodoTxtRb

Todo.txt CLI implemented in Ruby

## Installation

Install it yourself as:

    $ gem install todo_txt_rb

## Usage

Available Commands:"
"todo_rb add 'Thing you need to do'"
  Adds 'Thing you need to do' to your todo.txt file"

"todo_rb list"
  Lists your active todo's from your todo.txt file"

"todo_rb rm <todo number>"
  Removes a todo based on the todo number received"

"todo_rb do <todo number>"
  Marks a todo complete"

"todo_rb replace <todo number> 'New thing you need to do'"
  Replaces the Todo with a new todo"

"todo_rb listproj"
  lists all active projects"

"todo_rb listcontext"
  lists all active contexts"

"todo_rb --init"
  Creates todocfg.yml file in users home folder. Please edit this"
  file with the location of your todo.txt file"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
