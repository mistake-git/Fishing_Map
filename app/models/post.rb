class Post < ApplicationRecord
    before_validation :delete_whitespace
    validates :name, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
    validates :address, presence: true
    validates :latitude, presence: true
    validates :longitude,presence: true
    validates :user_id, {presence: true}
    validates :size,numericality:{greater_than_or_equal_to:1 ,message:'は1以上の値を入力して下さい'},allow_nil: true
    validates :size,numericality:{less_than:200 ,message:'は想定されない値です｡'},allow_nil: true
    validates :number,numericality:{greater_than_or_equal_to:1 ,message:'は1以上の値を入力して下さい'} 
    has_one_attached :image
    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :notifications, dependent: :destroy
    
  def user
    return User.find_by(id: self.user_id)
  end
  
  def self.search(search)
    if search
      Post.where(['name LIKE ?', "%#{search}%"])
    else
      Post.all
    end
  end
  
  def self.search_fishing_map(search)
    if search
      Post.where(['name LIKE ?', "%#{search}%"])
    else
      Post.all
    end
  end
  
  def create_notification_like!(current_user)
    #visitor_id = 1,visited_id = 1 ,post_id = 1 action = "like"
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id,user_id, id, 'like'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,#post_id = 1
        visited_id: user_id, # visited_id = 1
        action: 'like'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
    
  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
    save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end
  
  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    
    notification.save if notification.valid?
  end
  
  private
    def delete_whitespace
      self.name = name.strip
    end
  
end
