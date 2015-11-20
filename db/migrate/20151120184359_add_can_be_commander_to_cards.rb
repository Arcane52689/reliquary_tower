class AddCanBeCommanderToCards < ActiveRecord::Migration
  def change
    add_column :cards, :can_be_commander, :boolean
  end
end
