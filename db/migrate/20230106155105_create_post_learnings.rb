class CreatePostLearnings < ActiveRecord::Migration[6.1]
  def change
    create_table :post_learnings do |t|

      t.timestamps
    end
  end
end
