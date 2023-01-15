class ChangeCloumnsNotnullAddPostComments < ActiveRecord::Migration[6.1]
  def change
    change_column :post_comments, :comment, :string, null: false
  end
end
