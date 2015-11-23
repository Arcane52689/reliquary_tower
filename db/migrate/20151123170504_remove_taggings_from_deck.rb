class RemoveTaggingsFromDeck < ActiveRecord::Migration
  def change
    remove_column :decks, :taggings
  end
end
