class CreatePostLearnings < ActiveRecord::Migration[6.1]
  def change
    create_table :post_learnings do |t|
    t.integer :genre_id, foreign_key: true, null: false
    t.timestamps
    end
  end
end
