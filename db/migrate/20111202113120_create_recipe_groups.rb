class CreateRecipeGroups < ActiveRecord::Migration

  def change

    create_table :recipe_groups do |t|
      t.references :profession, :null => false
      t.references :user, :null => false
      t.string :name, :null => false
      t.integer :ah_duration, :null => false, :default => 24
      t.integer :max_restock_quantity, :null => false, :default => 5
      t.integer :min_restock_quantity, :null => false, :default => 3
      t.integer :post_cap, :null => false, :default => 2
      t.integer :per_auction, :null => false, :default => 1
      t.integer :profit_margin
      t.integer :fallback_margin
    end

    add_index :recipe_groups, :profession_id

  end

end
