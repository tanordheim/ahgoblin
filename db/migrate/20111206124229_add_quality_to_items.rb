class AddQualityToItems < ActiveRecord::Migration

  def change
    add_column :items, :quality, :integer, :null => false, :default => 0
  end

end
