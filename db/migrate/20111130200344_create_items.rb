class CreateItems < ActiveRecord::Migration

  def change

    create_table :items do |t|
      t.integer :item_id, :null => false
      t.integer :level, :null => false
      t.string :name, :null => false
      t.string :icon, :null => false
      t.integer :price, :null => false, :default => 0
      t.integer :sell_price, :null => false, :default => 0
    end

    add_index :items, :item_id, :unique => true

  end

end
