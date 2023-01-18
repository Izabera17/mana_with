class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post_learning
  
  has_many :notifications, dependent: :destroy
  
  validates :comment, presence: true
end
