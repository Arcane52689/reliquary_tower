class AddDescriptionToDeck < ActiveRecord::Migration
  def change
    add_column :categories, :is_keyword, :boolean, default: false
    add_column :categories, :is_tribal, :boolean, default: false

    add_column :decks, :description, :text
  end
end
