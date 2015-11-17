class AddUserIdToDeck < ActiveRecord::Migration
  def change
    add_column :decks, :user_id, :integer, index: true, foreign_key: true
  end
end
