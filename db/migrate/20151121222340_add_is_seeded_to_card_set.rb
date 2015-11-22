class AddIsSeededToCardSet < ActiveRecord::Migration
  def change
    add_column :card_sets, :is_seeded, :boolean
  end
  CardSet.all.each do |set|
    set.is_seeded = true
    set.save
  end
  
end
