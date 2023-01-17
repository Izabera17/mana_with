class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post_learnings, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_one_attached :user_image

  def get_profile_image(width, height)
    unless user_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      user_image.attach(io: File.open(file_path), filename: 'user-image.jpg', content_type: 'image/jpeg')
    end
    user_image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def self.looks(search)
    if search
      @user = User.where("name LIKE?","%#{search}%")
    else
      @user = User.all
    end
  end

end

