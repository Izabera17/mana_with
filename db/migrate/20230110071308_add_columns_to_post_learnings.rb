class AddColumnsToPostLearnings < ActiveRecord::Migration[6.1]
  def change
    add_reference :post_learnings, :user, foreign_key: true
    add_column :post_learnings, :learning_name, :string
    add_column :post_learnings, :learning_content, :string 
    add_column :post_learnings, :learning_real, :text
  end
end
