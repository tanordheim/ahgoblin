class ReagentGroup < ActiveRecord::Base

  # Reagent groups have many reagents.
  has_many :reagents, :dependent => :restrict

  # Reagent groups belongs to users.
  belongs_to :user

  # Validate that the reagent group is associated with a user.
  validates :user, :presence => true

  # Validate that the reagent group has a name and that its unique.
  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }

  # Order the reagent groups by name.
  scope :ordered_by_name, order('LOWER(reagent_groups.name) ASC')

  # Return reagent groups that should be included in the Auctioneer snatch list.
  scope :for_snatch_list, where(:include_in_snatch_list => true)

  # Include the reagents within the group in the query.
  scope :include_reagents, includes(:reagents => {
     
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

  })

end
