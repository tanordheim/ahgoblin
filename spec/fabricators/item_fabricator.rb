Fabricator(:item) do
  item_id { sequence(:item_id, 10000) }
  level { 1 }
  name { Faker::Lorem.sentence }
  icon { 'inv_ingot_10' }
  price { rand(1000) + 1 }
end
