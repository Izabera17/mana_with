class AddMessageIdToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :message_id, :integer
  end
end
