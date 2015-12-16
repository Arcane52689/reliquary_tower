class ChangeSetToAHasMany < ActiveRecord::Migration
  def change
    remove_column :card_sets, :card_ids
    add_column :cards, :card_set_id, :integer, null: false, index: true
  end
end
