require "bundler/gem_tasks"
require 'rspec/core/rake_task'

task :default => [:spec]

RSpec::Core::RakeTask.new(:spec)

task :build do
  exec 'gem build todo_txt_rb.gemspec'
end

task :install do
  exec 'gem install todo_txt_rb-0.0.1.gem'
end

task :doit => [:install, :build]
