class Tag < ApplicationRecord
  has_many :event_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :posts,through: :post_tags
end
