require "rake/testtask"

Rake::TestTask.new do |t|
  ENV["JEKYLL_ENV"] = "test"
  t.pattern = "spec/*_spec.rb"
end

desc "Run tests"
task :default => [:test]
