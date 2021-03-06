# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'todo_txt_rb/version'

Gem::Specification.new do |gem|
  gem.name          = "todo_txt_rb"
  gem.version       = TodoTxtRb::VERSION
  gem.authors       = ["Chris Lee"]
  gem.email         = ["finges@gmail.com"]
  gem.description   = "Ruby Implementation of the Todo.txt CLI"
  gem.summary       = "Ruby Implementation of the Todo.txt CLI"
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
