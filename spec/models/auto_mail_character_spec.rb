require 'spec_helper'

describe AutoMailCharacter do

  context '#attributes' do
    it { should have_db_column(:user_id).of_type(:integer).with_options(:null => false) }
    it { should have_db_column(:name).of_type(:string).with_options(:null => false) }
  end

  context '#associations' do
    it { should belong_to(:user) }
    it { should have_many(:auto_mail_items).dependent(:destroy) }
  end

  context '#validations' do
    before(:each) { Fabricate(:auto_mail_character) }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:user_id).case_insensitive }
  end

end
