class ChangeColorIdentity < ActiveRecord::Migration
  def change
    remove_column :cards, :color_identiy
    add_column :cards, :color_identity, :string, array: true, default: []
    remove_column :card_slots, :status
    add_column :card_slots, :location, :string, default: "main deck"
  end
end
