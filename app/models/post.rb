class Post < ApplicationRecord
    validates :name, presence: true,length: { maximum: 20 }     
    has_one_attached :image
end
