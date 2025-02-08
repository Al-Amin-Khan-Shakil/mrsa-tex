class CreateVariantValues < ActiveRecord::Migration[7.1]
  def change
    create_table :variant_values do |t|
      t.string :value
      t.string :slug
      t.decimal :price, precision: 10, scale: 2
      t.integer :stock
      t.references :variant_name, null: false, foreign_key: true

      t.timestamps
    end
    add_index :variant_values, :slug, unique: true
  end
end
