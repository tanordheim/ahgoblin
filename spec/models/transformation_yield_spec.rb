require 'spec_helper'

describe TransformationYield do

  context '#attributes' do
    it { should have_db_column(:transformation_id).of_type(:integer).with_options(:null => false) }
    it { should have_db_column(:quantity).of_type(:float).with_options(:null => false, :default => 1.0) }
    it { should have_db_column(:item_id).of_type(:integer).with_options(:null => false) }
  end

  context '#associations' do
    it { should belong_to(:transformation) }
    it { should belong_to(:item) }
  end

  context '#validations' do
    it { should validate_presence_of(:transformation) }
    it { should validate_presence_of(:item) }
  end

  context '#looking up item by item id' do
    before(:each) { register_fakeweb(:get, %r|http://eu.battle.net/|, 'item.json') }

    it 'should assign item by item id' do
      transformation_yield = TransformationYield.new(:item_lookup_id => 3371)
      transformation_yield.item.should_not be_blank
      transformation_yield.item.item_id.should == 3371
      transformation_yield.item.name.should == 'Crystal Vial'
    end
  end
  
end
