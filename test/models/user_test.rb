require 'test_helper'
class UserTest < ActiveSupport::TestCase
    
   test "create_user" do
     user = User.create(name: 'masataka',email:'test@gmail.com',address:'兵庫県')
     assert_equal('masataka',user.name)
     assert_equal('test@gmail.com',user.email)
     assert_equal('兵庫県',user.address)
   end
   
    test "update_user" do
    user = users :one
    user.update(name: 'masataka',email:'test@gmail.com',address:'兵庫県')
    assert_equal('masataka',user.name)
    assert_equal('test@gmail.com',user.email)
    assert_equal('兵庫県',user.address)
   end
   
end
