require 'spec_helper'

describe RecipeGroup do

  context '#attributes' do
    it { should have_db_column(:profession_id).of_type(:integer).with_options(:null => false) }
    it { should have_db_column(:user_id).of_type(:integer).with_options(:null => false) }
    it { should have_db_column(:name).of_type(:string).with_options(:null => false) }
    it { should have_db_column(:ah_duration).of_type(:integer).with_options(:null => false, :default => 24) }
    it { should have_db_column(:max_restock_quantity).of_type(:integer).with_options(:null => false, :default => 5) }
    it { should have_db_column(:min_restock_quantity).of_type(:integer).with_options(:null => false, :default => 3) }
    it { should have_db_column(:post_cap).of_type(:integer).with_options(:null => false, :default => 2) }
    it { should have_db_column(:per_auction).of_type(:integer).with_options(:null => false, :default => 1) }
    it { should have_db_column(:profit_margin).of_type(:integer) }
    it { should have_db_column(:fallback_margin).of_type(:integer) }
    it { should have_db_column(:create_tsm_groups_for_recipes).of_type(:boolean).with_options(:null => false, :default => true) }
    it { should have_db_column(:stockpile_character).of_type(:string) }
  end

  context '#associations' do
    it { should belong_to(:user) }
    it { should have_many(:recipes).dependent(:destroy) }
  end

  context '#validations' do
    it { should validate_presence_of(:profession) }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:ah_duration) }
    it { should allow_value(12).for(:ah_duration) }
    it { should allow_value(24).for(:ah_duration) }
    it { should allow_value(48).for(:ah_duration) }
    it { should_not allow_value(15).for(:ah_duration) }
  end

  context '#ah deposit multiplier' do
    it 'should have a multiplier of 1 for 12h auctions' do
      Fabricate(:recipe_group, :ah_duration => RecipeGroup::DURATION_12H).ah_deposit_multiplier.should == 1
    end

    it 'should have a multiplier of 2 for 24h auctions' do
      Fabricate(:recipe_group, :ah_duration => RecipeGroup::DURATION_24H).ah_deposit_multiplier.should == 2
    end

    it 'should have a multiplier of 4 for 48h auctions' do
      Fabricate(:recipe_group, :ah_duration => RecipeGroup::DURATION_48H).ah_deposit_multiplier.should == 4
    end
  end

end
