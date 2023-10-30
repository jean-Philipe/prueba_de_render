require 'simplecov'
SimpleCov.start 'rails' 
ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"


class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  SimpleCov.start 'rails' do
    add_group 'Models', 'app/models'
    add_group 'Controllers', 'app/controllers'
    add_group 'Helpers', 'app/helpers'
    add_group 'Mailers', 'app/mailers'
    add_group 'Jobs', 'app/jobs'
    add_group 'Channels', 'app/channels'
    add_group 'Views', 'app/views'
    add_group 'Config', 'config'
    add_group 'Lib', 'lib'
    add_group 'Test', 'test'
  end
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end
