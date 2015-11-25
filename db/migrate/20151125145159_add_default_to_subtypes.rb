class AddDefaultToSubtypes < ActiveRecord::Migration
  def change
    remove_column :cards, :subtypes
    add_column :cards, :subtypes, :string, array: true, default: []
    add_column :cards, :type_string, :string, null: false


  end
end
