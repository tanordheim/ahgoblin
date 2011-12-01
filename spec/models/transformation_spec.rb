require 'spec_helper'

describe Transformation do

  context '#attributes' do
    it { should have_db_column(:user_id).of_type(:integer).with_options(:null => false) }
    it { should have_db_column(:name).of_type(:string).with_options(:null => false) }
  end

  context '#associations' do
    it { should belong_to(:user) }
    it { should have_many(:reagents).dependent(:destroy) }
    it { should have_many(:yields).dependent(:destroy) }
  end

  context '#validations' do
    before(:each) { Fabricate(:transformation) }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:user_id).case_insensitive }
    it { should validate_presence_of(:reagents) }
    it { should validate_presence_of(:yields) }
  end
  
end
