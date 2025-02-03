class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.bigint :parent_id

      t.timestamps
    end
  end
end
