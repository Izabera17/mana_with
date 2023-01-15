class ChangeCloumnsNotnullAddGenres < ActiveRecord::Migration[6.1]
  def change
    change_column :genres, :name, :string, null: false
  end
end
