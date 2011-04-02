begin
  require ::File.expand_path('../.bundle/environment', __FILE__)
rescue LoadError
#  require 'rubygems'
  require 'bundler'
  Bundler.setup
end
Bundler.require :default, :build

require 'rake'
require 'rake/testtask'
require 'spec/rake/spectask'
require 'rake/rdoctask'

task :default => :spec

desc "Run all specs in spec directory (excluding plugin specs)"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.libs << File.dirname(__FILE__)
end
