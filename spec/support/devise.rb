require 'devise/test/controller_helpers'
RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
end
