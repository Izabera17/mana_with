class Tag < ApplicationRecord
  has_many :post_learning_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :post_learnings, through: :post_learning_tags
end
