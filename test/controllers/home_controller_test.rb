require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test '/' do
    get '/'
    assert_response :success
  end

end
