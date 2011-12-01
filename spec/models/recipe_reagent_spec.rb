require 'spec_helper'

describe RecipeReagent do

  context '#attributes' do
    it { should have_db_column(:recipe_id).of_type(:integer).with_options(:null => false) }
    it { should have_db_column(:reagent_id).of_type(:integer).with_options(:null => false) }
    it { should have_db_column(:quantity).of_type(:float).with_options(:null => false, :default => 1.0) }
  end

  context '#associations' do
    it { should belong_to(:recipe) }
    it { should belong_to(:reagent) }
  end

  context '#validations' do
    it { should validate_presence_of(:recipe) }
    it { should validate_presence_of(:reagent) }
  end

  context '#production cost' do
    let(:silver_bar) { Fabricate(:item, :item_id => 2842, :name => 'Silver Bar') }
    let(:silver_bar_reagent) do
      reagent = Fabricate.build(:reagent, :item => silver_bar, :components => [])
      reagent.components << Fabricate.build(:item_component, :reagent => reagent, :item => silver_bar, :price => 1000)
      reagent.save!
      reagent
    end

    let(:recipe_reagent) { Fabricate(:recipe_reagent, :reagent => silver_bar_reagent, :quantity => 2) }

    it 'should calculate the production cost' do
      recipe_reagent.production_cost.should == 2000
    end
  end
  
end
