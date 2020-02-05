class Comment < ApplicationRecord
    validates :user_id, {presence: true}
    validates :post_id, {presence: true}
    validates :content, {presence: true},length: { maximum: 100 ,message: 'は100文字以内で入力して下さい'}
    belongs_to :post
    belongs_to :user
    has_many :notifications, dependent: :destroy
    
  def user
    User.find_by(id: user_id)
  end
end
