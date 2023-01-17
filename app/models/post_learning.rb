class PostLearning < ApplicationRecord
  belongs_to :genre, optional: true
  belongs_to :user

  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_one_attached :post_image

  validates :learning_name, presence: true
  validates :learning_content, presence: true
  validates :learning_real, presence: true
  validates :genre_id, presence: true

  def self.search(search)
    if search
      where(['name LIKE ?', "%#{search}%"])
    else
      all
    end
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
