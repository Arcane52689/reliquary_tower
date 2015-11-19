class AddQuantityToCardSlot < ActiveRecord::Migration
  def change
    add_column :card_slots, :quantity, :integer, default: 1, null: false
  end
end
