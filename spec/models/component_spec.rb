require 'spec_helper'

describe Component do

  context '#attributes' do
    it { should have_db_column(:reagent_id).of_type(:integer).with_options(:null => false) }
    it { should have_db_column(:type).of_type(:string) }
    it { should have_db_column(:quantity).of_type(:float).with_options(:null => false, :default => 1.0) }
  end

  context '#associations' do
    it { should belong_to(:reagent) }
  end

  context '#validations' do
    it { should validate_presence_of(:reagent) }
  end

end
