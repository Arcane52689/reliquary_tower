class CreateCardSlots < ActiveRecord::Migration
  def change
    create_table :card_slots do |t|
      t.references :deck, index: true, foreign_key: true
      t.references :card, index: true, foreign_key: true
      t.string :status, null: false, default: "main deck"
      
      t.timestamps null: false
    end
  end
end
