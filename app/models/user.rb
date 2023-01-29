class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post_learnings, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  
  acts_as_followable 
  acts_as_follower

  has_one_attached :user_image

  validates :name, presence: true
  validates :email, presence: true

  # プロフィール画像のリサイズ
  def get_profile_image(width, height)
    # 画像がないときはデフォルト（no_image.jpg）をリサイズして表示
    unless user_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      user_image.attach(io: File.open(file_path), filename: 'user-image.jpg', content_type: 'image/jpeg')
    end
    # 投稿画像をリサイズして表示
    user_image.variant(resize_to_limit: [width, height]).processed
  end

  # いいねがあるか確認
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  # キーワードからユーザーを部分検索
  def self.looks(word)
    if word
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end
  
  # フォローされた時の処理
  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
end
