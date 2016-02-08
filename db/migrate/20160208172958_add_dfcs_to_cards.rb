class AddDfcsToCards < ActiveRecord::Migration
  def change
    add_column :cards, :has_alternate_side, :boolean, default: false;
    add_column :cards, :alternate_card_name, :string
  end
end
