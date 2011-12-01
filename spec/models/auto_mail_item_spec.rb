require 'spec_helper'

describe AutoMailItem do

  context '#attributes' do
    it { should have_db_column(:auto_mail_character_id).of_type(:integer).with_options(:null => false) }
    it { should have_db_column(:item_id).of_type(:integer).with_options(:null => false) }
  end

  context '#associations' do
    it { should belong_to(:auto_mail_character) }
    it { should belong_to(:item) }
  end

  context '#validations' do
    it { should validate_presence_of(:auto_mail_character) }
    it { should validate_presence_of(:item) }
  end

end
