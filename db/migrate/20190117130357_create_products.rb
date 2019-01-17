class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
    	t.string :item_type
      t.string :sku
      t.string :Title
      t.string :serial_number
      t.integer :quantity
      t.float :price
      t.string :organization
      t.float :Length
      t.float :Breadth
      t.float :Height
      t.float :Weight
      t.string :description
      t.string :short_description
      t.string :asset_code
      t.string :grade
      t.string :category
      t.string :brand
      t.float :volume
      t.timestamps
    end
  end
end
