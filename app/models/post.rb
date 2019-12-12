class Post < ApplicationRecord
    validates :name, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
    validates :address, presence: true
    validates :user_id, {presence: true}
    has_one_attached :image
    geocoded_by :address
    after_validation :geocode
    
  def user
    return User.find_by(id: self.user_id)
  end
    
end
