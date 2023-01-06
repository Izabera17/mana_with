class CreatePostLearningTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_learning_tags do |t|
      t.references :post_learning, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
