class CreateAutoMailItems < ActiveRecord::Migration

  def change

    create_table :auto_mail_items do |t|
      t.references :auto_mail_character, :null => false
      t.references :item, :null => false
    end

    add_index :auto_mail_items, :auto_mail_character_id

  end

end
