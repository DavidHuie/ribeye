require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'
require 'jeweler'

Jeweler::Tasks.new do |gem|
  gem.name = "ribeye"
  gem.homepage = "http://github.com/DavidHuie/ribeye"
  gem.license = "MIT"
  gem.summary = 'A Ruby client to the Beef bloom filter server'
  gem.description = 'A Ruby client to the Beef bloom filter server'
  gem.email = "dahuie@gmail.com"
  gem.authors = ["David Huie"]
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

task :default => :spec
