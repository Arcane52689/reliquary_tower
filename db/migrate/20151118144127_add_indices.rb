class AddIndices < ActiveRecord::Migration
  def change
    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
    add_index :decks, :taggings
    add_index :cards, :name

  end
end
