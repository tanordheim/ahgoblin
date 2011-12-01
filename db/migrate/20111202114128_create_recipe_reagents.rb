class CreateRecipeReagents < ActiveRecord::Migration

  def change

    create_table :recipe_reagents do |t|
      t.references :recipe, :null => false
      t.references :reagent, :null => false
      t.float :quantity, :null => false, :default => 1.0
    end

    add_index :recipe_reagents, :recipe_id
    add_index :recipe_reagents, :reagent_id

  end

end
