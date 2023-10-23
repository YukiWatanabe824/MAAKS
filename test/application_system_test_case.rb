require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Devise::Test::IntegrationHelpers

  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]

  Capybara.configure do |config|
    config.run_server = true
    config.default_driver = :selenium
    config.default_max_wait_time = 5
    config.ignore_hidden_elements = true
  end
end
