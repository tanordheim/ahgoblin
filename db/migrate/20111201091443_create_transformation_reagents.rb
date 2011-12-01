class CreateTransformationReagents < ActiveRecord::Migration

  def change

    create_table :transformation_reagents do |t|
      t.references :transformation, :null => false
      t.float :quantity, :null => false, :default => 1.0
      t.references :reagent, :null => false
    end

    add_index :transformation_reagents, :transformation_id

  end

end
