class Post < ApplicationRecord
    before_validation :delete_whitespace
    validates :name, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
    validates :latitude, presence: true
    validates :longitude,presence: true
    validates :address,presence: true
    validates :user_id, presence: true
    validates :size,numericality:{greater_than_or_equal_to:1 ,message:'は1以上の値を入力して下さい'},allow_nil: true
    validates :size,numericality:{less_than:200 ,message:'は想定されない値です｡'},allow_nil: true
    validates :number,numericality:{greater_than_or_equal_to:1 ,message:'は1以上の値を入力して下さい'} 
    has_one_attached :image
    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :notifications, dependent: :destroy
    has_many :post_tag_relations, dependent: :destroy
    has_many :tags, through: :post_tag_relations
    geocoded_by :address
    after_validation :geocode, if: Proc.new { |a| a.address_changed? }
    
  def user
    return User.find_by(id: self.user_id)
  end
  
  def save_tags(tag_list)
    tag_list.each do |tag|
      unless find_tag = Tag.find_by(tag_name: tag)
        begin
          self.tags.create!(tag_name: tag)
        rescue
          nil
        end
      else
        PostTagRelation.create!(post_id: self.id, tag_id: find_tag.id)
      end
    end
  end
  
  def update_tags(tag_list)
    self.post_tag_relations.delete_all
    tag_list.each do |tag|
      unless find_tag = Tag.find_by(tag_name: tag)
        begin
          self.tags.create!(tag_name: tag)
        rescue
          nil
        end
      else
        PostTagRelation.create!(post_id: self.id, tag_id: find_tag.id)
      end
    end
  end
  
  
  def create_notification_like!(current_user)
    if user_id == current_user.id
      return
    end
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id,user_id, id, 'like'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'like'
    )
      notification.save if notification.valid?
    end
  end
    
  def create_notification_comment!(current_user, comment_id)
    if user_id == current_user.id
      return
    end
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
    notification.save if notification.valid?
  end
  
  
  private
    def delete_whitespace
      self.name = name.strip
    end
  
end
