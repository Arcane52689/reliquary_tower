class AddStatementToCategoriess < ActiveRecord::Migration
  def change
    add_column :categories, :statement, :text
  end
end
