require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test '/users' do
    get '/users'
    assert_response :success
  end
  
  test '/users/:id' do
    get '/users/:id'
    assert_response :success
  end
  
end      
      
      