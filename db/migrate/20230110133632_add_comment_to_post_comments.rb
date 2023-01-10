class AddCommentToPostComments < ActiveRecord::Migration[6.1]
  def change
    add_reference :post_comments, :user, foreign_key: true
    add_reference :post_comments, :post_learning, foreign_key: true
    add_column :post_comments, :comment, :string
  end
end
