class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.references :category, index: true, foreign_key: true, null: false
      t.integer :taggable_id, null: false
      t.string :taggable, null: false

      t.timestamps null: false
    end

    add_index :taggings, [:category_id, :taggable, :taggable_id], unique: true

  end
end
