class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :tags_name

      t.timestamps
    end
    add_index :tags, :tags_name, unique: true
  end
end
