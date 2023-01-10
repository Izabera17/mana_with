class Genre < ApplicationRecord
  has_many :post_learnings, dependent: :destroy

  validates :name, presence: true 
end
