require 'spec_helper'

describe Recipe do

  context '#attributes' do
    it { should have_db_column(:recipe_group_id).of_type(:integer).with_options(:null => false) }
    it { should have_db_column(:item_id).of_type(:integer).with_options(:null => false) }
  end

  context '#associations' do
    it { should belong_to(:recipe_group) }
    it { should belong_to(:item) }
    it { should have_many(:reagents).dependent(:destroy) }
  end

  context '#validations' do
    it { should validate_presence_of(:recipe_group) }
    it { should validate_presence_of(:item) }
    it { should validate_presence_of(:reagents) }
  end

  context '#costs' do
    let(:silver_rod) { Fabricate(:item, :item_id => 6338, :name => 'Silver Rod', :price => 1000, :sell_price => 2000) }

    let(:silver_bar) { Fabricate(:item, :item_id => 2842, :name => 'Silver Bar') }
    let(:silver_bar_reagent) do
      reagent = Fabricate.build(:reagent, :item => silver_bar, :components => [])
      reagent.components << Fabricate.build(:item_component, :reagent => reagent, :item => silver_bar, :price => 1000)
      reagent.save!
      reagent
    end

    let(:grinding_stone) { Fabricate(:item, :item_id => 3470, :name => 'Rough Grinding Stone') }
    let(:grinding_stone_reagent) do
      reagent = Fabricate.build(:reagent, :item => grinding_stone, :components => [])
      reagent.components << Fabricate.build(:item_component, :reagent => reagent, :item => grinding_stone, :price => 500)
      reagent.save!
      reagent
    end

    let(:recipe) do
      recipe = Fabricate.build(:recipe, :item => silver_rod, :reagents => [])
      recipe.reagents << Fabricate.build(:recipe_reagent, :recipe => recipe, :reagent => silver_bar_reagent, :quantity => 1)
      recipe.reagents << Fabricate.build(:recipe_reagent, :recipe => recipe, :reagent => grinding_stone_reagent, :quantity => 2)
      recipe.save!
      recipe
    end

    context '#production costs' do
      it 'should calculate the production cost' do
        recipe.production_cost.should == 2000
      end
    end

    context '#ah deposit' do
      it 'should calculate the deposit for 12h duration' do
        recipe.recipe_group.ah_duration = 12
        recipe.ah_deposit.should == 300
      end

      it 'should calculate the deposit for 24h duration' do
        recipe.recipe_group.ah_duration = 24
        recipe.ah_deposit.should == 600
      end

      it 'should calculate the deposit for 48h duration' do
        recipe.recipe_group.ah_duration = 48
        recipe.ah_deposit.should == 1200
      end
    end

    context '#minimum price' do
      it 'should calculate the minimum sell price' do
        # production cost = 2000
        # ah deposit = 600
        # profit margin = 105%
        # == 2730
        recipe.minimum_price.should == 2730
      end

      it 'should calculate the minimum sell price with an overridden profit margin' do

        recipe.recipe_group.profit_margin = 200

        # production cost = 2000
        # ah deposit = 600
        # profit margin = 200%
        # == 5200
        recipe.minimum_price.should == 5200
       
      end
    end
    
    context '#fallback price' do
      it 'should calculate the fallback price' do
        # minimum price = 2730
        # fallback margin = 250%
        # == 6825
        recipe.fallback_price.should == 6825
      end

      it 'should calculate the fallback price with an overridden fallback margin' do

        recipe.recipe_group.fallback_margin = 500

        # minimum price = 2730
        # fallback margin = 500%
        # == 13650
        recipe.fallback_price.should == 13650

      end

      it 'should calculate the fallback price with an overridden profit and fallback margin' do

        recipe.recipe_group.profit_margin = 200
        recipe.recipe_group.fallback_margin = 500

        # minimum price = 5200
        # fallback margin = 500%
        # == 26000
        recipe.fallback_price.should == 26000
        
      end
    end
  end
  
end
