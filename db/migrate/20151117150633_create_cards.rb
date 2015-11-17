class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name, null: false
      t.string :mana_cost, null: false
      t.integer :cmc, null: false
      t.string :colors, array: true, default: []
      t.string :color_identiy, array: true, default: []
      t.string :supertypes, array: true, default: []
      t.string :types, array: true, default: []
      t.string :subtypes, array: true, defaults: []
      t.string :rarity, limit: 50, null: false
      t.text :card_text, null:false
      t.text  :flavor_text
      t.string :power
      t.string :toughness
      t.integer :multiverse_id, null: false

      t.timestamps null: false
    end
  end
end
