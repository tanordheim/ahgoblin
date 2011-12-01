class Transformation < ActiveRecord::Base

  # Transformations are associated with users.
  belongs_to :user

  # Transformations have many reagents, and accepts nested attributes.
  has_many :reagents, :class_name => 'TransformationReagent', :dependent => :destroy, :before_add => :add_transformation_to_reagent
  accepts_nested_attributes_for :reagents, :allow_destroy => true

  # Transformations have many yields, and accepts nested attributes.
  has_many :yields, :class_name => 'TransformationYield', :dependent => :destroy, :before_add => :add_transformation_to_yield
  accepts_nested_attributes_for :yields, :allow_destroy => true

  # Validate that the transformation is associated with a user.
  validates :user, :presence => true

  # Validate that the transformation has a name set, and that its unique.
  validates :name, :presence => true, :uniqueness => { :scope => :user_id, :case_sensitive => false }

  # Validate that the transformation has one or more reagents defined.
  validates :reagents, :presence => true

  # Validate that the transformation has one or more yields defined.
  validates :yields, :presence => true

  # Order transformations by name.
  scope :ordered_by_name, order('LOWER(transformations.name) ASC')

  # Includes the reagents in the query.
  scope :include_reagents, includes(:reagents => { :reagent => :item })

  # Includes the yields in the query.
  scope :include_yields, includes(:yields => :item)

  # Returns the total cost of the reagents.
  def reagent_cost
    reagents.map do |reagent|
      reagent.reagent.production_cost
    end.sum
  end

  # Returns the value of a item yielded from the transformation, based on the
  # item quantity and the total price of the reagents.
  def value_of_yielded_item(item)
    item = yields.select { |y| y.item_id == item.id }.first
    if item.blank?
      0
    else
      (reagent_cost / item.quantity).to_i
    end
  end

  private

  # Add a transformation reference to a newly built transformation reagent.
  def add_transformation_to_reagent(reagent)
    reagent.transformation = self
  end

  # Add a transformation reference to a newly built tranasformation yield.
  def add_transformation_to_yield(transformation_yield)
    transformation_yield.transformation = self
  end

end
