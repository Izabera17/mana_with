class DropPostLearningTags < ActiveRecord::Migration[6.1]
  def change
      drop_table :post_learning_tags do |t|
        t.integer :post_learning_id
        t.integer :tag_id

      t.timestamps
    end
  end
end
