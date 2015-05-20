require 'pathname'
require 'logger'

module Simulation

  def self.app
    "robot"
  end

  def self.root
    @root ||= Pathname.new(__FILE__).dirname + '..'
  end

  def self.log_file
    root + "log/#{app}_#{environment}.log"
  end

  def self.logger
    @logger ||= Logger.new(log_file)
  end

  def self.development?
    environment == :development
  end

  def self.test?
    environment == :test
  end

  def self.production?
    environment == :production
  end

  def self.environment
    ENV.fetch("APP_ENV", "development").to_sym
  end
end
