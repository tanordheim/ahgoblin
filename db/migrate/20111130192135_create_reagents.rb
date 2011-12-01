class CreateReagents < ActiveRecord::Migration

  def change

    create_table :reagents do |t|
      t.references :reagent_group, :null => false
      t.references :item, :null => false
    end

    add_index :reagents, :reagent_group_id
    add_index :reagents, :item_id

  end

end
