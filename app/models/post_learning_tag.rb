class PostLearningTag < ApplicationRecord
  belongs_to :post_learning
  belongs_to :tag
end
