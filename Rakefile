$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require 'rubygems'
require 'rspec/core/rake_task'

require 'haplocheirus/version'

task :default => :spec

desc 'Run all specs in spec/'
RSpec::Core::RakeTask.new do |t|
  t.ruby_opts = ['-Ilib', '-Ispec']
end

desc 'Build the gem'
task :build do
  system "gem build haplocheirus-client.gemspec"
end
