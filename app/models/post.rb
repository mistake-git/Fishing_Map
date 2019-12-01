class Post < ApplicationRecord
    validates :name, presence: true,length: { maximum: 20 }     
    has_one_attached :image
    geocoded_by :address
    after_validation :geocode
end
