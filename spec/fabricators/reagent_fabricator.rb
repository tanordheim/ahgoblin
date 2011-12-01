Fabricator(:reagent) do
  reagent_group!
  item!
  components(:count => 1) { |reagent, i| Fabricate.build(:component, :reagent => reagent) }
end
