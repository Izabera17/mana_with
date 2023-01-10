class DropTags < ActiveRecord::Migration[6.1]
  def change
    drop_table :tags do |t|
      t.string :tags_name
       
      t.timestamps
    end
  end
end
