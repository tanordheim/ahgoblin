require 'spec_helper'

describe Item do

  context '#attributes' do
    it { should have_db_column(:item_id).of_type(:integer).with_options(:null => false) }
    it { should have_db_column(:level).of_type(:integer).with_options(:null => false) }
    it { should have_db_column(:name).of_type(:string).with_options(:null => false) }
    it { should have_db_column(:icon).of_type(:string).with_options(:null => false) }
    it { should have_db_column(:price).of_type(:integer).with_options(:null => false, :default => 0) }
    it { should have_db_column(:sell_price).of_type(:integer).with_options(:null => false, :default => 0) }
    it { should have_db_column(:quality).of_type(:integer).with_options(:null => false, :default => 0) }
  end

  context '#associations' do
    it { should have_many(:reagents).dependent(:restrict) }
    it { should have_many(:recipes).dependent(:restrict) }
  end

  context '#validations' do
    before(:each) { Fabricate(:item) }
    it { should validate_presence_of(:item_id) }
    it { should validate_uniqueness_of(:item_id) }
    it { should validate_presence_of(:level) }
    it { should validate_presence_of(:name) }
  end

  context '#loading from battle.net' do
    it 'should build an item' do
      register_fakeweb(:get, %r|http://eu.battle.net/|, 'item.json')

      item = Item.from_api(3371)
      item.item_id.should == 3371
      item.level.should == 1
      item.name.should == 'Crystal Vial'
      item.icon.should == 'inv_alchemy_leadedvial'
      item.price.should == 100
      item.sell_price.should == 5
      item.quality.should == 1

    end

    it 'should handle error responses' do
      register_fakeweb(:get, %r|http://eu.battle.net/|, 'item_error.json', '500')
      Item.from_api(3371).should_not be_valid
    end

    it 'should handle request errors' do
      register_fakeweb(:get, %r|http://eu.battle.net/|, 'invalid_json.json', '500')
      Item.from_api(3371).should_not be_valid
    end

    context '#find_or_load' do
      it 'should fetch an item from the api' do
        register_fakeweb(:get, %r|http://eu.battle.net/|, 'item.json')
        Item.find_or_load(3371).new_record?.should be_false
      end

      it 'should load from the database' do

        register_fakeweb(:get, %r|http://eu.battle.net/|, 'invalid_json.json')
        Fabricate(:item, :item_id => 3371)

        # This will be a new record if the item isn't found in the database, as validation will fail and it will not have been persisted.
        Item.find_or_load(3371).new_record?.should be_false

      end

      it 'should be unpersisted if load failed' do
        register_fakeweb(:get, %r|http://eu.battle.net/|, 'invalid_json.json')
        Item.find_or_load(3371).new_record?.should be_true
      end
    end
  end

end
