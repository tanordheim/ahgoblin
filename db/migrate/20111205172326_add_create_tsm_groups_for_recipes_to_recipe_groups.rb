class AddCreateTsmGroupsForRecipesToRecipeGroups < ActiveRecord::Migration

  def change
    add_column :recipe_groups, :create_tsm_groups_for_recipes, :boolean, :null => false, :default => true
  end

end
