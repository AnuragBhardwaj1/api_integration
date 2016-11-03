class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :status
      t.string :cost
      t.integer :pickup_id
      t.integer :drop_id
      t.decimal :estimated_pickup_time
      t.decimal :estimated_delivery_time
      t.string :request_id
      t.string :name
      t.decimal :age

      t.timestamps null: false
    end
  end
end
