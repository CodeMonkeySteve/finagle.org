require 'bundler'
Bundler.setup
Bundler.require :default, :test

Spork.prefork do
#  require 'spec/autorun'

  # rspec configuration
  Spec::Runner.configure do |config|
    config.mock_with :rr
  end

  Dir[File.dirname(__FILE__)+'/support/**/*.rb'].each { |f| require f }
end

Spork.each_run do
  # clear screen
  print "\x1b[2J\x1b[H" ; $stdout.flush

  require File.dirname(__FILE__) + '/../comics'

  # set test environment
  set :environment, :test
  set :run, false
  set :raise_errors, true
  set :logging, false
end

