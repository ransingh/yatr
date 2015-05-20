require 'rubygems'
require 'bundler/setup'

Bundler.require(:default, :test, :development)

ENV["APP_ENV"] ||= "test"

$:.unshift File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'simulation'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
