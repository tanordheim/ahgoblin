class AutoMailCharacter < ActiveRecord::Base

  # Auto mail characters belong to a user.
  belongs_to :user

  # Auto mail characters have many auto mail items.
  has_many :auto_mail_items, :dependent => :destroy

  # Validate that the auto mail character has a user set.
  validates :user, :presence => true

  # Validate that the auto mail character has a character name set, and that its
  # unique for the user.
  validates :name, :presence => true, :uniqueness => { :scope => :user_id, :case_sensitive => false }

  # Orders the auto mail characters by character name.
  scope :ordered_by_name, order('LOWER(auto_mail_characters.name) ASC')

  # Include the items for the character in the query.
  scope :include_items, includes(:auto_mail_items => :item)

end
