require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
    test "create_relationships" do
        user1 = users :one
        user2 = users :two
        relationship = Relationship.create(followed_id: user2.id,follower_id: user1.id)
        assert_equal(user1.id,relationship.follower_id)
        assert_equal(user2.id,relationship.followed_id)
    end
    
    test "destroy_relationships" do
        relationship = relationships :one
        relationship.destroy
        assert_nil Relationship.find_by(id: relationship.id)
    end
end
