require 'spec_helper'

describe ItemComponent do

  context '#attributes' do
    it { should have_db_column(:item_id).of_type(:integer) }
    it { should have_db_column(:price).of_type(:integer) }
    it { should have_db_column(:use_vendor_price).of_type(:boolean).with_options(:null => false, :default => false) }
  end

  context '#associations' do
    it { should belong_to(:item) }
  end

  context '#validations' do
    it { should validate_presence_of(:item) }

    it 'should validate presence of price if not using vendor price' do
      Fabricate.build(:item_component, :price => nil, :use_vendor_price => false).should_not be_valid
      Fabricate.build(:item_component, :price => 1000, :use_vendor_price => false).should be_valid
    end

    it 'should not validate presence of price if using vendor price' do
      Fabricate.build(:item_component, :price => nil, :use_vendor_price => true).should be_valid
    end

    it 'should not nullify price if not using vendor price' do
      Fabricate(:item_component, :price => 1000, :use_vendor_price => false).price.should_not be_nil
    end

    it 'should nullify price if using vendor price' do
      Fabricate(:item_component, :price => 1000, :use_vendor_price => true).price.should be_nil
    end
  end

  context '#looking up item by item id' do
    before(:each) { register_fakeweb(:get, %r|http://eu.battle.net/|, 'item.json') }

    it 'should assign item by item id' do
      component = ItemComponent.new(:item_lookup_id => 3371)
      component.item.should_not be_blank
      component.item.item_id.should == 3371
      component.item.name.should == 'Crystal Vial'
    end
  end

  context '#production cost' do
    let(:item) { Fabricate(:item) }
    let(:component) { Fabricate(:item_component, :item => item, :price => 1000, :quantity => 2) }

    it 'should calculate production cost' do
      component.production_cost.should == 2000
    end
  end

  context '#parsing price strings' do
    it 'should extract gold amount' do
      ItemComponent.new(:price_string => '10g').price.should == 100000
    end

    it 'should extract silver amount' do
      ItemComponent.new(:price_string => '10s').price.should == 1000
    end

    it 'should extract copper amount' do
      ItemComponent.new(:price_string => '10c').price.should == 10
    end

    it 'should extract partial combinations' do
      ItemComponent.new(:price_string => '10g 10c').price.should == 100010
      ItemComponent.new(:price_string => '10g10c').price.should == 100010
    end

    it 'should extract full combinations' do
      ItemComponent.new(:price_string => '10g 10s 10c').price.should == 101010
      ItemComponent.new(:price_string => '10g10s10c').price.should == 101010
    end
  end

end
