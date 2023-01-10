class AddUserToFavorites < ActiveRecord::Migration[6.1]
  def change
    add_reference :favorites, :user, foreign_key: true
    add_reference :favorites, :post_learning, foreign_key: true
  end
end
