class RenameCommentIdColumnToNotifications < ActiveRecord::Migration[6.1]
  def change
    rename_column :notifications, :comment_id, :post_comment_id
  end
end
