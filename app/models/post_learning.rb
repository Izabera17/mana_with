class PostLearning < ApplicationRecord
  has_many :post_learning_tags, dependent: :destroy
  has_many :tags, through: :post_learning_tags
  
  belongs_to :user
  
  has_one_attached :post_image
end
