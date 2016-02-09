class RemoveHasAlternateFace < ActiveRecord::Migration
  def change
    remove_column :cards, :has_alternate_side, :boolean
    add_column :cards, :is_flip_card, :boolean, default: false

    remove_column :printings, :multiverse_id, :integer
    add_column :printings, :multiverse_id, :integer, null: false, index: true
  end
end
