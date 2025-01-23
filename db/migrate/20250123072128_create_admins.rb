class CreateAdmins < ActiveRecord::Migration[7.1]
  def change
    create_table :admins do |t|
      t.string :f_name
      t.string :l_name
      t.string :role
      t.string :gender
      t.string :phone_number

      t.timestamps
    end
  end
end
