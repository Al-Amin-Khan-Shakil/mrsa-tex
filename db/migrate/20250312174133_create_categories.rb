class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories, id: :uuid do |t|
      t.string :name
      t.string :slug
      t.uuid :parent_id

      t.timestamps
    end
    add_index :categories, :slug, unique: true
  end
end
