ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all
    def sign_in
        visit "/users/sigin_in"
        fill_in "session-email", with:"test@example.com"
        fill_in "session-password",with:"testtest"
        click_on "login-btn"
    end
  # Add more helper methods to be used by all tests here...
end
