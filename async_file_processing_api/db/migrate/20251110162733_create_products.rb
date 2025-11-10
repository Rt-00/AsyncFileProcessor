class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :sku
      t.decimal :price, precision: 10, scale: 2
      t.text :description
      t.integer :stock, default: 0

      t.timestamps
    end
  end
end
