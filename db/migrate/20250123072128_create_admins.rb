class CreateAdmins < ActiveRecord::Migration[7.1]
  def change
    create_table :admins do |t|
      t.string :f_name
      t.string :l_name
      t.integer :role, limit: 2
      t.integer :gender, limit: 2
      t.string :phone_number

      t.timestamps
    end
  end
end
