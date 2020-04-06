class Comment < ApplicationRecord
    validates :user_id, presence: true
    validates :post_id, presence: true
    validates :content, presence: true
    belongs_to :post
    belongs_to :user
    has_many :notifications, dependent: :destroy
end
