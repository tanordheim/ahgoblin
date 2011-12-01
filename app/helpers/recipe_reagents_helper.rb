module RecipeReagentsHelper

  # Get an element identifier for the specified recipe reagent.
  def element_id_for_recipe_reagent(recipe_reagent)
    recipe_reagent.new_record? ? Time.now.to_f.to_s.gsub('.', '') : recipe_reagent.id
  end

end
