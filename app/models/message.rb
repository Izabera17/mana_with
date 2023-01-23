class Message < ApplicationRecord
  validates :body, presence: true
  
  has_many :notifications, dependent: :destroy
  belongs_to :user
  belongs_to :room
end
