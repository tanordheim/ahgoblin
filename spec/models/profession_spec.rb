require 'spec_helper'

describe Profession do

  context '#attributes' do
    it { should have_db_column(:name).of_type(:string).with_options(:null => false) }
  end

  context '#associations' do
    it { should have_many(:recipe_groups).dependent(:restrict) }
  end

  context '#validations' do
    before(:each) { Fabricate(:profession) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

end
