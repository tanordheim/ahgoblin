class AutoMailItem < ActiveRecord::Base

  # Auto mail items belong to auto mail characters.
  belongs_to :auto_mail_character

  # Auto mail items belong to items.
  belongs_to :item

  # Validate that the auto mail item has a character set.
  validates :auto_mail_character, :presence => true

  # Validate that the auto mail item has an item set.
  validates :item, :presence => true

  # Returns all auto mail items for the specified user.
  scope :for_user, lambda { |user| includes(:auto_mail_character).where(:auto_mail_characters => { :user_id => user.id }) }

  # Orders the auto mail items by the item name.
  scope :ordered_by_name,includes(:item).order('LOWER(items.name) ASC')

  # Assign the item on the recipe by looking up the specified item ID.
  def item_lookup_id=(item_lookup_id)
    self.item = Item.find_or_load(item_lookup_id.to_i)
  end

  # Returns the current item lookup id.
  def item_lookup_id
    item.blank? ? nil : item.item_id
  end
  
end
