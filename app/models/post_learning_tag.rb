class PostLearningTag < ApplicationRecord
  belongs_to :post_learning
  belongs_to :tag
  validates :post_learning_id, presence: true
  validates :tag_id, presence: true
end
