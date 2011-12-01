Fabricator(:transformation) do
  user!
  name { Faker::Lorem.sentence }
  reagents(:count => 1) { |transformation, i| Fabricate.build(:transformation_reagent, :transformation => transformation) }
  yields(:count => 1) { |transformation, i| Fabricate.build(:transformation_yield, :transformation => transformation) }
end
