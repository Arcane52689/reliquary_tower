class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.references :category, index: true, foreign_key: true
      t.string :taggable_type, null: false
      t.integer :taggable_id, null: false


      t.timestamps null: false
    end

    add_index :taggings, [:category_id, :taggable_type, :taggable_id], unique: true
  end
end
