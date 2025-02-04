class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      t.integer :stock
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
    add_index :products, :slug, unique: true
  end
end
