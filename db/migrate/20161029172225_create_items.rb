class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :type
      t.references :order

      t.timestamps null: false
    end
  end
end
