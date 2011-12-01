require 'spec_helper'

describe ReagentComponent do

  context '#attributes' do
    it { should have_db_column(:reagent_id).of_type(:integer) }
  end

  context '#associations' do
    it { should belong_to(:reagent) }
  end

  context '#validations' do
    it { should validate_presence_of(:reagent) }
  end

  context '#production cost' do
    let(:item) { Fabricate(:item) }
    let(:reagent) do
      reagent = Fabricate.build(:reagent, :components => [])
      reagent.components << Fabricate.build(:item_component, :reagent => reagent, :item => item, :quantity => 2, :price => 1000)
      reagent.save!
      reagent
    end
    let(:component) { Fabricate(:reagent_component, :reagent_reference => reagent, :quantity => 2) }

    it 'should calculate production cost' do
      component.production_cost.should == 4000
    end
  end

end
