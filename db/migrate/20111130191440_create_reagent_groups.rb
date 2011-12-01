class CreateReagentGroups < ActiveRecord::Migration

  def change

    create_table :reagent_groups do |t|
      t.references :user, :null => false
      t.string :name, :null => false
      t.boolean :include_in_snatch_list, :null => false, :default => true
    end

    add_index :reagent_groups, :user_id

  end
end
