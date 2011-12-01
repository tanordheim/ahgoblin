class Recipe < ActiveRecord::Base

  # Recipes are associated with recipe groups.
  belongs_to :recipe_group

  # Recipes are associated with items.
  belongs_to :item

  # Recipes have many reagents, and we accept nested attributes.
  has_many :reagents, :class_name => 'RecipeReagent', :dependent => :destroy, :before_add => :add_recipe_to_recipe_reagents
  accepts_nested_attributes_for :reagents, :allow_destroy => true

  # Validate that the recipe has a recipe group association.
  validates :recipe_group, :presence => true

  # Validate that the recipe has an item association.
  validates :item, :presence => true

  # Validate that the recipe has at least one reagent.
  validates :reagents, :presence => true

  # Returns all recipes for the specifie user.
  scope :for_user, lambda { |user| includes(:recipe_group).where(:recipe_groups => { :user_id => user.id }) }

  # Order the recipes by the associated item name.
  scope :ordered_by_name, includes(:item).order('LOWER(items.name) ASC')

  # Includes the recipe group in the query.
  scope :include_group, includes(:recipe_group => :profession)

  # Includes the item in the query.
  scope :include_item, includes(:item)

  # Includes reagents in the query.
  scope :include_reagents, includes(:reagents => {
    :reagent => {

      # Preload item components and their items.
      :item_components => :item,

      # Preload reagent components, their reagents and those reagents items.
      :reagent_components => { :reagent_reference => :item },

      # Preload transformation components, and the full transformation data set.
      :transformation_components => {
        :transformation => {
          :reagents => { :reagent => :item },
          :yields => :item
        }
      }
      
    }
  })

  # Assign the item on the recipe by looking up the specified item ID.
  def item_lookup_id=(item_lookup_id)
    self.item = Item.find_or_load(item_lookup_id.to_i)
  end

  # Returns the current item lookup id.
  def item_lookup_id
    item.blank? ? nil : item.item_id
  end
  
  # Calculate the production cost of the recipe.
  def production_cost
    reagents.map do |reagent|
      reagent.production_cost
    end.sum
  end

  # Calculate the auction house deposit of the recipe.
  # 
  # This follows the standard Auction House deposit formula:
  # Deposit (12hr auction) = 0.15 * MSV 
  # Deposit (24hr auction) = 2 * Deposit (12hr auction)
  # Deposit (48hr auction) = 4 * Deposit (12hr auction)
  def ah_deposit
    msv = item.sell_price
    base_deposit = msv * 0.15
    (base_deposit * recipe_group.ah_deposit_multiplier).to_i
  end

  # Calculate the minimum price of the recipe.
  #
  # This is calculated by taking the production cost and AH deposit of the
  # item, then factoring in the profit margin percentage.
  def minimum_price
    price = production_cost + ah_deposit
    margin = recipe_group.profit_margin.blank? || recipe_group.profit_margin == 0 ? DEFAULT_PROFIT_MARGIN : recipe_group.profit_margin
    (price / 100) * margin
  end

  # Calculate the fallback price of the recipe.
  #
  # This is calculated by taking the minimum price and factoring in the
  # fallback margin percentage.
  def fallback_price
    price = minimum_price
    margin = recipe_group.fallback_margin.blank? || recipe_group.fallback_margin == 0 ? DEFAULT_FALLBACK_MARGIN : recipe_group.fallback_margin
    (price / 100) * margin
  end

  private

  # Add a reference to this recipe to any recipe reagents added to the
  # collection.
  def add_recipe_to_recipe_reagents(recipe_reagent)
    recipe_reagent.recipe = self
  end

end
