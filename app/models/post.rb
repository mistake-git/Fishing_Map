class Post < ApplicationRecord
    validates :name, presence: true,length: { maximum: 20 }
    validates :address, presence: true
    validates :user_id, {presence: true}
    has_one_attached :image
    geocoded_by :address
    after_validation :geocode
    
  def user
    return User.find_by(id: self.user_id)
  end
    
end
