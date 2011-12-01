class TransformationYield < ActiveRecord::Base

  # Transformation yields belong to transformations.
  belongs_to :transformation

  # Transformation yields belong to items.
  belongs_to :item

  # Valiate that the transformation yield is associated with a transformation.
  validates :transformation, :presence => true

  # Validate that the transformation yield is associated with an item.
  validates :item, :presence => true

  # Assign the item on the yield by looking up the specified item ID.
  def item_lookup_id=(item_lookup_id)
    self.item = Item.find_or_load(item_lookup_id.to_i)
  end

  # Returns the current item lookup id.
  def item_lookup_id
    item.blank? ? nil : item.item_id
  end
  
end
