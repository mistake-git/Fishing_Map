class Post < ApplicationRecord
    validates :name, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
    validates :address, presence: true
    validates :user_id, {presence: true}
    has_one_attached :image
    geocoded_by :address
    after_validation :geocode
    belongs_to :user
    has_many :likes, dependent: :destroy
    
  def user
    return User.find_by(id: self.user_id)
  end
  
  def self.search(search)
    if search
      Post.where(['title LIKE ?', "%#{search}%"])
    else
      Post.all
    end
  end
    
end
