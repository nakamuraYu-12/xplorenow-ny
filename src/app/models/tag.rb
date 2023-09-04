class Tag < ApplicationRecord
  has_many :event_tags, dependent: :destroy
  has_many :posts, through: :post_tags
end
