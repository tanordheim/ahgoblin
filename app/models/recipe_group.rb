class RecipeGroup < ActiveRecord::Base

  DURATION_12H = 12
  DURATION_24H = 24
  DURATION_48H = 48

  # Recipe groups belong to professions.
  belongs_to :profession

  # Recipe groups belong to users.
  belongs_to :user

  # Recipe groups are associated with recipes.
  has_many :recipes, :dependent => :destroy

  # Validate that the recipe group is associated with a profession.
  validates :profession, :presence => true

  # Validate that the recipe group is associated with a user.
  validates :user, :presence => true

  # Validate that the recipe group has a name.
  validates :name, :presence => true

  # Validate that the ah duration field is set, and that is has a valid value.
  validates :ah_duration, :presence => true, :inclusion => { :in => [DURATION_12H, DURATION_24H, DURATION_48H] }

  # Returns all recipe groups for the specified profession.
  scope :for_profession, lambda { |profession| where(:profession_id => profession.id) }

  # Returns all recipe groups for the specified user.
  scope :for_user, lambda { |user| where(:user_id => user.id) }

  # Order the recipe groups by the name of the associated profession.
  scope :ordered_by_profession_name, includes(:profession).order('LOWER(professions.name) ASC')

  # Order the recipe groups by name.
  scope :ordered_by_name, order('LOWER(recipe_groups.name) ASC')

  # Include the recipes within the group in the query.
  scope :include_recipes, includes(:recipes => :item).includes(:recipes => {
      :reagents => {
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
      }
  })

  # Returns the name of this recipe group, prefixed with the associated
  # profession name.
  def name_with_profession
    "#{profession.name}: #{name}"
  end

  # Returns the AH deposit multiplier to apply to the item vendor value.
  # 
  # This follows the standard Auction House deposit formula:
  # Deposit (12hr auction) = 0.15 * MSV 
  # Deposit (24hr auction) = 2 * Deposit (12hr auction)
  # Deposit (48hr auction) = 4 * Deposit (12hr auction)
  def ah_deposit_multiplier
    case ah_duration
    when DURATION_24H then return 2
    when DURATION_48H then return 4
    else return 1
    end
  end

end
