class CreateTransformationYields < ActiveRecord::Migration

  def change

    create_table :transformation_yields do |t|
      t.references :transformation, :null => false
      t.float :quantity, :null => false, :default => 1.0
      t.references :item, :null => false
    end

    add_index :transformation_yields, :transformation_id

  end

end
