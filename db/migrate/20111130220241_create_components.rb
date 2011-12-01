class CreateComponents < ActiveRecord::Migration

  def change

    create_table :components do |t|
      t.references :reagent, :null => false
      t.string :type
      t.integer :reagent_reference_id
      t.references :item
      t.references :transformation
      t.float :quantity, :null => false, :default => 1.0
      t.integer :price
      t.boolean :use_vendor_price, :null => false, :default => false
    end

    add_index :components, :reagent_id
    add_index :components, :type

  end

end
