require '"bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'lib/wpa_cli_ruby'
  t.test_files = FileList['test/lib/wpa_cli_ruby/*_test.rb']
  t.verbose = true
end

task :default => :test
