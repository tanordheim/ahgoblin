Fabricator(:reagent_group) do
  user!
  name { Faker::Lorem.sentence }
end
