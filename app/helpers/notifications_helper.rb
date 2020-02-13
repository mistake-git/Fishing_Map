module NotificationsHelper
    def notification_form(notification)
      @comment = nil
      visitor = link_to notification.visitor.name, "/users/#{notification.visitor.id}",style:"font-weight: bold; color: #00CCCC"
      your_post = link_to 'あなたの投稿',notification.post, style:"font-weight: bold; color: #00CCCC"
      @post = Post.find_by(id:notification.post_id)
      post_name = link_to "#{@post.name}",notification.post ,style:"font-weight: bold; color: #00CCCC"
      case notification.action
        when "follow" then
          "#{visitor}があなたをフォローしました"
        when "like" then
          "#{visitor}が#{your_post}にいいね！しました"
        when "comment" then
          @comment=Comment.find_by(id:notification.comment_id).content
          "#{visitor}が#{your_post}にコメントしました"
        when "post" then
        "#{visitor}が#{post_name}を釣り上げました"
      end
    end
    
    def unchecked_notifications
         @notifications = current_user.passive_notifications.where(checked: false)
    end  
end