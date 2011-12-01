Fabricator(:component) do
  reagent!
  quantity { 1 }
end

Fabricator(:reagent_component, :from => :component, :class_name => :reagent_component) do
  reagent_reference! { Fabricate(:reagent) }
end

Fabricator(:item_component, :from => :component, :class_name => :item_component) do
  item!
  price { rand(1000) + 1 }
end

Fabricator(:transformation_component, :from => :component, :class_name => :transformation_component) do
  transformation!
end
