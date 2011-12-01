require 'spec_helper'

describe Reagent do

  context '#attributes' do
    it { should have_db_column(:reagent_group_id).of_type(:integer).with_options(:null => false) }
    it { should have_db_column(:item_id).of_type(:integer).with_options(:null => false) }
  end

  context '#associations' do
    it { should belong_to(:reagent_group) }
    it { should belong_to(:item) }
    it { should have_many(:components).dependent(:destroy) }
    it { should have_many(:item_components) }
    it { should have_many(:reagent_components) }
    it { should have_many(:transformation_components) }
    it { should have_many(:transformation_reagents).dependent(:restrict) }
    it { should have_many(:reagent_component_references).dependent(:restrict) }
    it { should have_many(:recipe_reagents).dependent(:restrict) }
  end

  context '#validations' do
    before(:each) { Fabricate(:reagent) }
    it { should validate_presence_of(:reagent_group) }
    it { should validate_presence_of(:item) }
    it { should validate_uniqueness_of(:item_id) }
    it { should validate_presence_of(:components) }
  end

  context '#looking up item by item id' do
    before(:each) { register_fakeweb(:get, %r|http://eu.battle.net/|, 'item.json') }

    it 'should assign item by item id' do
      reagent = Reagent.new(:item_lookup_id => 3371)
      reagent.item.should_not be_blank
      reagent.item.item_id.should == 3371
      reagent.item.name.should == 'Crystal Vial'
    end
  end

  context '#production costs' do
    context '#item components' do
      let(:silver_bar) { Fabricate(:item, :item_id => 2842, :name => 'Silver Bar') }
      let(:silver_ore) { Fabricate(:item, :item_id => 2775, :name => 'Silver Ore') }
      let(:reagent) do
        reagent = Fabricate.build(:reagent, :item => silver_bar, :components => [])
        reagent.components << Fabricate.build(:item_component, :reagent => reagent, :item => silver_ore, :quantity => 2, :price => 1000)
        reagent
      end

      it 'should calculate the production cost' do
        reagent.production_cost.should == 2000
      end
    end
  end

end
