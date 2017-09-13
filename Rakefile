require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rubycritic/rake_task'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

RubyCritic::RakeTask.new

task default: :test
