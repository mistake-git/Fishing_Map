class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[twitter]
  validates :name, presence: true ,length: { maximum: 20 ,message: 'は20文字以内で入力して下さい｡'}
  validates :email,  length: { maximum: 50 }
  has_one_attached :image
  has_one_attached :bg_image
  geocoded_by :address
  after_validation :geocode
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :likes_posts,through: :likes, source: :post
  has_many :comments, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  
  def posts
    return Post.where(user_id: self.id)
  end
  
  def self.search(search)
    if search
      User.where(['name LIKE ?', "%#{search}%"])
    else
      User.all
    end
  end
  
  def follow(other_user)
    following << other_user
  end

 
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end


  def following?(other_user)
    following.include?(other_user)
  end
  
  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
  
  def create_notification_post!(visited_id,current_user,post_id)
      current_user.followers.each do |follower|
          visited_id = follower.id
      end 
      notification = current_user.active_notifications.new(
        post_id: post_id,
        visitor_id: current_user.id,
        visited_id: visited_id,
        action:'post'
      )
      notification.save if notification.valid?
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.image = auth.info.image_url
      user.password = Devise.friendly_token[0,20]
    end
  end
  
end
