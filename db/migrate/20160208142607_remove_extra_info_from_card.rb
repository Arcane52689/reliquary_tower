class RemoveExtraInfoFromCard < ActiveRecord::Migration
  def change
    remove_column :cards, :card_set_id
    remove_column :cards, :multiverse_id
    remove_column :cards, :flavor_text
    remove_column :cards, :rarity

    remove_column :bans, :card_name
    add_column :bans, :card_id, :integer, null: false
    add_index :bans, [:format, :card_id], unique: true


  end
end
