class ItemComponent < Component

  # Item components belong to items.
  belongs_to :item

  # Validate that the item component has an item association.
  validates :item, :presence => true

  # Validate that the item component has a price set, unless the component is
  # set to use the vendor price.
  validates :price, :presence => { :unless => :use_vendor_price? }

  # Before saving the model, set price to nil if the item is set to use the
  # venor price.
  before_save :unset_price_if_using_vendor_price

  # Assign the item on the component by looking up the specified item ID.
  def item_lookup_id=(item_lookup_id)
    self.item = Item.find_or_load(item_lookup_id.to_i)
  end

  # Returns the current item lookup id.
  def item_lookup_id
    item.blank? ? nil : item.item_id
  end

  # Returns the production cost of the item component.
  def production_cost
    price = use_vendor_price? ? item.price : self.price
    price * quantity
  end

  # Defines the price of the item component using plain text format (Xg Ys
  # Zc).
  def price_string=(price_string)

    gold, silver, copper = 0, 0, 0
    gold = $1.to_i if price_string =~ /(\d+)g/
    silver = $1.to_i if price_string =~ /(\d+)s/
    copper = $1.to_i if price_string =~ /(\d+)c/

    value = copper + silver * 100 + gold * 10000
    self.price = value

  end

  # Returns the price of the item component using plain text format (Xg YS
  # Zc).
  def price_string

    money = self.price || 0
    copper = money % 100
    amount = (money - copper) / 100
    silver = amount % 100
    gold = (amount - silver) / 100

    parts = []
    parts << "#{number_with_delimiter(gold.to_i)}g" if gold > 0
    parts << "#{silver.to_i}s" if silver > 0
    parts << "#{copper.to_i}c" if copper > 0

    parts.join(' ')
    
  end

  private

  # Unset the price attribute of the item component if the item component is
  # configured to use the venor price.
  def unset_price_if_using_vendor_price
    self.price = nil if use_vendor_price?
  end

end
