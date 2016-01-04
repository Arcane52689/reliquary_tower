class CreateBans < ActiveRecord::Migration
  def change
    create_table :bans do |t|
      t.string :format, null: false, index: true
      t.string :card_name, null: false, index: true
      t.boolean :restricted, null: false, default: true
      t.timestamps null: false
    end
  end
end
