require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
    test "create_relationships" do
        relationship = Relationship.create(follow_id: 1)
        assert_equal(1,relationship.follow_id)
        
    end
    
    test "destroy_relationships" do
        relationship = Relationship.create(follow_id: 1)
        assert_equal(1,relationship.follow_id)
        assert_empty(Relationship.follow_id)
    end
end
