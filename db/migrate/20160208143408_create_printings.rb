class CreatePrintings < ActiveRecord::Migration
  def change
    create_table :printings do |t|
      t.references :card, index: true, foreign_key: true
      t.references :card_set, index: true, foreign_key: true
      t.integer :multiverse_id, null: false, unique: true, index: true
      t.text :flavor_text
      t.string :rarity

      t.timestamps null: false
    end
  end
end
