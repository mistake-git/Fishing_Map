class Fish < ApplicationRecord
     validates :name, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'},uniqueness: true
      validates :level, presence: true
end
