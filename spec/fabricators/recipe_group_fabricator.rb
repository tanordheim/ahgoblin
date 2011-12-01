Fabricator(:recipe_group) do
  profession!
  user!
  name { Faker::Lorem.sentence }
end
