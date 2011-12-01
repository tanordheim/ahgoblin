class CreateRecipes < ActiveRecord::Migration

  def change

    create_table :recipes do |t|
      t.references :recipe_group, :null => false
      t.references :item, :null => false
    end

    add_index :recipes, :recipe_group_id
    add_index :recipes, :item_id

  end

end
