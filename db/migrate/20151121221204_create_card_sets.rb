class CreateCardSets < ActiveRecord::Migration
  def change
    create_table :card_sets do |t|
      t.string :name, null: false, unique: true
      t.integer :card_ids, array: true, default: []
  
      t.timestamps null: false
    end
  end
end
