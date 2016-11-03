class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :house_number
      t.string :block
      t.string :locality
      t.string :city
      t.string :state
      t.string :pincode

      t.timestamps null: false
    end
  end
end
