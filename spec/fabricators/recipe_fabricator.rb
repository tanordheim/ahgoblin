Fabricator(:recipe) do
  recipe_group!
  item!
  reagents(:count => 1) { |recipe, i| Fabricate.build(:recipe_reagent, :recipe => recipe) }
end
