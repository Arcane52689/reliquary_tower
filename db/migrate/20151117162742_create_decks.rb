class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.string :name, null: false
      t.string :format, null: false
      t.string :taggings, array: true, default: []
      t.boolean :is_prototype, default: true

      
      t.timestamps null: false
    end
  end
end
