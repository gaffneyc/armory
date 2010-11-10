# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require 'rspec'
require 'armory'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.expand_path("../spec/support/**/*.rb", __FILE__)].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  # config.mock_with :mocha
  config.mock_with :mocha

  def fixture(fixture)
    File.read(File.expand_path("../fixtures/#{fixture}.xml", __FILE__))
  end
end
