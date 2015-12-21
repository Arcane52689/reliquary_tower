class AddProducesManaToCards < ActiveRecord::Migration
  def change
    add_column :cards, :produces_mana, :string, array: true, default: []
  end
end
