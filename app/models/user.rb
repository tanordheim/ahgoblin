class User < ActiveRecord::Base

  # Users have passwords and can be used to authenticate.
  has_secure_password

  # Users are associated with reagent groups.
  has_many :reagent_groups

  # Users are associated with transformations.
  has_many :transformations

  # Users are associated with recipe groups.
  has_many :recipe_groups

  # Users are associated with auto-mail characters.
  has_many :auto_mail_characters

  # Validate that the user has an email address set, and that the address is
  # unique.
  validates :email, :presence => true, :uniqueness => { :case_sensitive => false }

  # Validate that the user has a password set when being created.
  validates :password, :presence => { :on => :create }

end
