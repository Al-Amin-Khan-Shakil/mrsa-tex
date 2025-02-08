class CreateVariantNames < ActiveRecord::Migration[7.1]
  def change
    create_table :variant_names do |t|
      t.string :name
      t.string :slug
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
    add_index :variant_names, :slug, unique: true
  end
end
