class PostLearning < ApplicationRecord
  belongs_to :genre, optional: true
  belongs_to :user

  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :notifications, dependent: :destroy

  has_one_attached :post_image

  validates :learning_name, presence: true
  validates :learning_content, presence: true
  validates :learning_real, presence: true
  validates :genre_id, presence: true

  # キーワードから投稿を部分検索
  def self.looks(range, word)
    if range == "学習名"
      @post_learning = PostLearning.where("learning_name LIKE?","%#{word}%")
    elsif range == "頑張ったこと"
      @post_learning = PostLearning.where("learning_content LIKE?","%#{word}%")
    else
      @post_learning = PostLearning.all
    end
  end
  
  # いいねがあるか確認
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  # いいねされた時の処理
  def create_notification_favorite!(current_user)
    # いいねされているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_learning_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
    #いいねされていない時に通知を作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_learning_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      # 自分に対するいいねの場合、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid? 
    end
  end
  
  
  # 投稿された時の処理
    def create_notification_post_comment!(current_user, post_comment_id)
    # 自分以外でコメントしている人の投稿を全取得し、全員に通知する
    temp_ids = PostComment.select(:user_id).where(post_learning_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, post_comment_id, temp_id['user_id'])
    end
    # コメントがない場合は、投稿者に通知する
    save_notification_post_comment!(current_user, post_comment_id, user_id) if temp_ids.blank?
  end
  
  
  def save_notification_post_comment!(current_user, post_comment_id, visited_id)
    # １つの投稿に複数回通知できるようにする
    notification = current_user.active_notifications.new(
      post_learning_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: 'post_comment'
    )
    # 自分への投稿は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
  

end
