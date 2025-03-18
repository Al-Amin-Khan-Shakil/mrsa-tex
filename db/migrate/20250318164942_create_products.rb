class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products, id: :uuid do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      t.integer :stock
      t.boolean :active
      t.references :category, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
