require 'spec_helper'

describe ReagentGroup do

  context '#attributes' do
    it { should have_db_column(:user_id).of_type(:integer).with_options(:null => false) }
    it { should have_db_column(:name).of_type(:string).with_options(:null => false) }
    it { should have_db_column(:include_in_snatch_list).of_type(:boolean).with_options(:null => false, :default => true) }
  end

  context '#associations' do
    it { should belong_to(:user) }
    it { should have_many(:reagents).dependent(:restrict) }
  end

  context '#validations' do
    before(:each) { Fabricate(:reagent_group) }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

end
