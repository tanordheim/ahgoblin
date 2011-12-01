require 'spec_helper'

describe User do

  context '#attributes' do
    it { should have_db_column(:email).of_type(:string).with_options(:null => false) }
    it { should have_db_column(:password_digest).of_type(:string).with_options(:null => false) }
  end

  context '#associations' do
    it { should have_many(:reagent_groups) }
    it { should have_many(:transformations) }
    it { should have_many(:recipe_groups) }
    it { should have_many(:auto_mail_characters) }
  end

  context '#validations' do
    before(:each) { Fabricate(:user) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

end
