class CreateUploads < ActiveRecord::Migration[8.1]
  def change
    create_table :uploads do |t|
      t.string :filename
      t.string :content_type
      t.integer :product_count, default: 0
      t.string :status, default: 'pending'
      t.text :error_message

      t.timestamps
    end
  end
end
