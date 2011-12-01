require 'spec_helper'

describe TransformationComponent do

  context '#attributes' do
    it { should have_db_column(:transformation_id).of_type(:integer) }
  end

  context '#associations' do
    it { should belong_to(:transformation) }
  end

  context '#validations' do
    it { should validate_presence_of(:transformation) }
  end

  context '#production cost' do

    # Items
    let(:abyss_crystal) { Fabricate(:item, :item_id => 34057, :name => 'Abyss Crystal') }
    let(:infinite_dust) { Fabricate(:item, :item_id => 34054, :name => 'Infinite Dust') }
    let(:greater_cosmic_essence) { Fabricate(:item, :item_id => 34055, :name => 'Greater Cosmic Essence') }

    let(:shatter_transformation) do
      transformation = Fabricate.build(:transformation, :name => 'Abyss Shatter', :reagents => [], :yields => [])
      transformation.reagents << Fabricate.build(:transformation_reagent, :reagent => abyss_crystal_reagent, :quantity => 1)
      transformation.yields << Fabricate.build(:transformation_yield, :item => infinite_dust, :quantity => 4.57)
      transformation.yields << Fabricate.build(:transformation_yield, :item => greater_cosmic_essence, :quantity => 1.95)
      transformation.save!
      transformation
    end

    # Reagents.
    let(:abyss_crystal_reagent) do
      reagent = Fabricate.build(:reagent, :item => abyss_crystal, :components => [])
      reagent.components << Fabricate.build(:item_component, :reagent => reagent, :item => abyss_crystal, :price => 300000)
      reagent.save!
      reagent
    end
    let(:greater_cosmic_essence_reagent) do
      reagent = Fabricate.build(:reagent, :item => greater_cosmic_essence, :components => [])
      reagent.components << Fabricate.build(:transformation_component, :reagent => reagent, :transformation => shatter_transformation)
      reagent.save!
      reagent
    end
    let(:infinite_dust_reagent) do
      reagent = Fabricate.build(:reagent, :item => infinite_dust, :components => [])
      reagent.components << Fabricate.build(:transformation_component, :reagent => reagent, :transformation => shatter_transformation)
      reagent.save!
      reagent
    end

    it 'should calculate production cost of infinite dust' do
      infinite_dust_reagent.production_cost.should == 65645
    end

    it 'should calculate production cost of greater cosmic essence' do
      greater_cosmic_essence_reagent.production_cost.should == 153846
    end
  end

end
