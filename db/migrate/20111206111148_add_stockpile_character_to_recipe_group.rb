class AddStockpileCharacterToRecipeGroup < ActiveRecord::Migration

  def change
    add_column :recipe_groups, :stockpile_character, :string
  end

end
