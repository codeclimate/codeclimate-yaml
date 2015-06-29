require "rake/testtask"
require "bundler/gem_tasks"

Rake::TestTask.new do |t|
  t.test_files = Dir.glob('spec/**/*_spec.rb')
  t.libs = ["lib", "spec"]
end

task(default: :test)

desc "load console"

task :console do
  require "pry"
  require_relative "environment.rb"
  binding.pry(quiet: true, prompt: Pry::SIMPLE_PROMPT, output: $stdout)
end
