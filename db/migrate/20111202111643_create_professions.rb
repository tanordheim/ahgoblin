class CreateProfessions < ActiveRecord::Migration

  def change

    create_table :professions do |t|
      t.string :name, :null => false
    end

    add_index :professions, :name, :unique => true

  end
end
