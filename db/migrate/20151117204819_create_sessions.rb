class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.string :token, index: true, null: false
      t.text :browser_data

      t.timestamps null: false
    end
  end
end
