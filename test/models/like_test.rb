require 'test_helper'

class LikeTest < ActiveSupport::TestCase
    test "create_like" do
        like = Like.new(user_id: 1, post_id: 1)
        assert_equal(1,like.user_id)
        assert_equal(1,like.post_id)
    end
    
    test "destroy_like" do
        like = Like.new(user_id: 1, post_id: 1)
        like.destroy
    end
end
