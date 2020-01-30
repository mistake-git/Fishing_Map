require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
    test "notification_like" do
        notification = Notification.create(visitor_id: 1,visited_id: 2,post_id: 1,action: 'like')
        assert_equal(notification.visitor_id,1)
        assert_equal(notification.visited_id,2)
        assert_equal(notification.post_id,1)
        assert_equal(notification.action,'like')
    end
    
    test "notification_comment" do
        notification = Notification.create(visitor_id: 1,visited_id: 2,post_id: 1,comment_id: 1,action: 'comment')
        assert_equal(notification.visitor_id,1)
        assert_equal(notification.visited_id,2)
        assert_equal(notification.post_id,1)
        assert_equal(notification.comment_id,1)
        assert_equal(notification.action,'comment')
    end
    
    test "notification_follow" do
        notification = Notification.create(visitor_id: 1,visited_id: 2,action: 'follow')
        assert_equal(notification.visitor_id,1)
        assert_equal(notification.visited_id,2)
        assert_equal(notification.action,'follow')
    end
    
    test "notification_post" do
        notification = Notification.create(visitor_id: 1,visited_id: 2,post_id: 1,action: 'post')
        assert_equal(notification.visitor_id,1)
        assert_equal(notification.visited_id,2)
        assert_equal(notification.post_id,1)
        assert_equal(notification.action,'post')
        
    end
end
