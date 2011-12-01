class Reagent < ActiveRecord::Base

  # Reagents belong to reagent groups.
  belongs_to :reagent_group

  # Reagents belong to items.
  belongs_to :item

  # Reagents have many components, and accepts nested attributes.
  has_many :components, :dependent => :destroy

  # Reagents have many item components, and accepts nested attributes.
  has_many :item_components, :before_add => :add_parent_to_component
  accepts_nested_attributes_for :item_components, :allow_destroy => true

  # Reagents have many reagent components, and accepts nested attributes.
  has_many :reagent_components, :before_add => :add_parent_to_component
  accepts_nested_attributes_for :reagent_components, :allow_destroy => true

  # Reagents have many transformation components, and accepts nested attributes.
  has_many :transformation_components, :before_add => :add_parent_to_component
  accepts_nested_attributes_for :transformation_components, :allow_destroy => true

  # Reagents are associated with transformation reagents.
  has_many :transformation_reagents, :dependent => :restrict

  # Reagents can be referenced in one or more reagent component, restrict
  # cascading deletes.
  has_many :reagent_component_references, :class_name => 'ReagentComponent', :foreign_key => 'reagent_reference_id', :dependent => :restrict

  # Reagents can be referenced in one or more recipes, restrict cascading
  # deletes.
  has_many :recipe_reagents, :dependent => :restrict

  # Validate that the reagent has a group association.
  validates :reagent_group, :presence => true

  # Validate that the reagent has an item association, and that only this is the
  # only reagent definition for the item.
  validates :item, :presence => true
  validates :item_id, :uniqueness => true

  # Validate that the reagent has one or more components.
  validates :components, :presence => { :unless => :has_specific_components? }

  # Order the reagents by the item name.
  scope :ordered_by_name, includes(:item).order('LOWER(items.name) ASC')

  # Returns all reagents owned by the specified user.
  scope :for_user, lambda { |user| includes(:reagent_group).where(:reagent_groups => { :user_id => user.id }) }

  # Include the components in the query.
  scope :include_components, includes(:item_components => :item).includes(:reagent_components => { :reagent_reference => :item }).includes(:transformation_components => {
    :transformation => {
      :reagents => { :reagent => :item },
      :yields => :item
    }
  })

  # Assign the item on the reagent by looking up the specified item ID.
  def item_lookup_id=(item_lookup_id)
    self.item = Item.find_or_load(item_lookup_id.to_i)
  end

  # Returns the current item lookup id.
  def item_lookup_id
    item.blank? ? nil : item.item_id
  end

  # Returns the production cost of the reagent.
  def production_cost
    components.map do |component|
      component.production_cost
    end.sum
  end

  # Alias method that returns the name of the associated item, if any.
  def name
    item.blank? ? nil : item.name
  end

  # Returns an array identifying the item sources for this reagent.
  def item_sources
    sources = []
    sources << 'AH' unless item_components.select { |s| !s.use_vendor_price? }.empty?
    sources << 'Vendor' unless item_components.select { |s| s.use_vendor_price? }.empty?
    sources << 'Trans.' unless transformation_components.empty?
    sources << 'Craft' unless reagent_components.empty?
    sources
  end
  
  private

  # Add a parent reference to a newly built reagent component.
  def add_parent_to_component(component)
    component.reagent = self
  end

  # Returns true if one of the specific types of component collections have one
  # or more items present.
  def has_specific_components?
    !item_components.empty? || !reagent_components.empty? || !transformation_components.empty?
  end

end
