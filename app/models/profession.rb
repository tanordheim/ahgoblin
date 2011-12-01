class Profession < ActiveRecord::Base

  # Professions have many recipe groups.
  has_many :recipe_groups, :dependent => :restrict

  # Validate that the profession has a name, and that the name is unique.
  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }

  # Order professions by their name.
  scope :ordered_by_name, order('LOWER(professions.name) ASC')

end
