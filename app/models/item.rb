class Item < ActiveRecord::Base

  QUALITY_POOR = 0
  QUALITY_COMMON = 1
  QUALITY_UNCOMMON = 2
  QUALITY_RARE = 3
  QUALITY_EPIC = 4
  QUALITY_LEGENDARY = 5
  QUALITY_ARTIFACT = 6
  QUALITY_HEIRLOOM = 7

  # Items have many reagents.
  has_many :reagents, :dependent => :restrict

  # Items have many recipes.
  has_many :recipes, :dependent => :restrict

  # Validate that the item has an item id set, and that the item id is unique.
  validates :item_id, :presence => true, :uniqueness => true

  # Validate that the item has an item level set.
  validates :level, :presence => true

  # Validate that the item has a name.
  validates :name, :presence => true

  # Filter items by the specified term. This searches the item_id and name
  # attributes, and only matches the beginning of the string.
  scope :filter_by_term, lambda { |term|
    where(['items.name ILIKE ? OR CAST(items.item_id AS varchar) ILIKE ?', "#{term}%", "#{term}%"])
  }

  # Order the items by name.
  scope :ordered_by_name, order('LOWER(items.name) ASC')

  # Build an item instance by using the Battle.net API.
  def self.from_api(item_id)
    item = self.new(:item_id => item_id)
    item.refresh_from_api
    item
  end

  # Find an item in the database, or load it from the API and persist it if it
  # doesn't exist.
  def self.find_or_load(item_id)

    item = find_by_item_id(item_id)
    if item.blank? && !item_id.blank?
      item = from_api(item_id)
    end

    item

  end

  # Refresh the data on this item from the API.
  def refresh_from_api

    data = {}
    unless item_id.blank?
      begin
        data = JSON.parse(api.item(item_id).body, :symbolize_names => true)
      rescue
        data = {}
      end
    end

    if !data[:status] && data[:id]
      self.item_id = data[:id].to_i
      self.level = data[:itemLevel].to_i
      self.name = data[:name]
      self.icon = data[:icon]
      self.price = data[:buyPrice].to_i
      self.sell_price = data[:sellPrice].to_i
      self.quality = data[:quality].to_i
    end

    save

  end

  private

  # Returns an instance of the Battle.net API.
  def api
    @api ||= Battlenet.new(:eu)
  end

end
