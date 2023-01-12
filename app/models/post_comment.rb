class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post_learning
  
  validates :comment, presence: true
end
