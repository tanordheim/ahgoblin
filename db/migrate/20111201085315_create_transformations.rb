class CreateTransformations < ActiveRecord::Migration

  def change

    create_table :transformations do |t|
      t.references :user, :null => false
      t.string :name, :null => false
    end

    add_index :transformations, [:user_id, :name], :unique => true

  end

end
