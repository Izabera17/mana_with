class PostLearning < ApplicationRecord
  has_many :post_learning_tags, dependent: :destroy
  has_many :tags, through: :post_learning_tags
  
  belongs_to :genre, optional: true
  
  belongs_to :user
  
  has_one_attached :post_image
  
   def self.search(search)
        if search
          where(['name LIKE ?', "%#{search}%"]) 
        else
          all 
        end
    end
  
end
