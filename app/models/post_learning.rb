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
  validates :word, presence: true
  

  def self.looks(range, word)
    if range == "学習名"
      @post_learning = PostLearning.where("learning_name LIKE?","%#{word}%")
    elsif range == "頑張ったこと"
      @post_learning = PostLearning.where("learning_content LIKE?","%#{word}%")
    else
      @post_learning = PostLearning.all
    end
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
