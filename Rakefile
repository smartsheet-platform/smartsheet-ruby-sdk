require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rubycritic/rake_task'


Rake::TestTask.new do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

namespace :test do
  Rake::TestTask.new(:units) do |t|
    t.libs << 'test'
    t.pattern = 'test/unit/**/*_test.rb'
    t.verbose = true
  end

  Rake::TestTask.new(:mock_api) do |t|
    t.libs << 'test'
    t.pattern = 'test/mock_api/**/*_test.rb'
    t.verbose = true
  end
end


RubyCritic::RakeTask.new

task default: :'test:units'
