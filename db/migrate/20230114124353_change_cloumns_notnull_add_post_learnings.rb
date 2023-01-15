class ChangeCloumnsNotnullAddPostLearnings < ActiveRecord::Migration[6.1]
  def change
    change_column :post_learnings, :learning_name, :string, null: false
    change_column :post_learnings, :learning_content, :string, null: false
    change_column :post_learnings, :learning_real, :text, null: false
  end
end
