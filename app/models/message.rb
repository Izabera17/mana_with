class Message < ApplicationRecord
  validates :body, presence: true, length: { minimum: 1, maximum: 200 }
  
  has_many :notifications, dependent: :destroy
  belongs_to :user
  belongs_to :room
end
