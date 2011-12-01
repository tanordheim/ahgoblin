class CreateAutoMailCharacters < ActiveRecord::Migration

  def change

    create_table :auto_mail_characters do |t|
      t.references :user, :null => false
      t.string :name, :null => false
    end

    add_index :auto_mail_characters, :user_id
    add_index :auto_mail_characters, [:user_id, :name], :unique => true

  end

end
