# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111206173310) do

  create_table "auto_mail_characters", :force => true do |t|
    t.integer "user_id", :null => false
    t.string  "name",    :null => false
  end

  add_index "auto_mail_characters", ["user_id", "name"], :name => "index_auto_mail_characters_on_user_id_and_name", :unique => true
  add_index "auto_mail_characters", ["user_id"], :name => "index_auto_mail_characters_on_user_id"

  create_table "auto_mail_items", :force => true do |t|
    t.integer "auto_mail_character_id", :null => false
    t.integer "item_id",                :null => false
  end

  add_index "auto_mail_items", ["auto_mail_character_id"], :name => "index_auto_mail_items_on_auto_mail_character_id"

  create_table "components", :force => true do |t|
    t.integer "reagent_id",                              :null => false
    t.string  "type"
    t.integer "reagent_reference_id"
    t.integer "item_id"
    t.integer "transformation_id"
    t.float   "quantity",             :default => 1.0,   :null => false
    t.integer "price"
    t.boolean "use_vendor_price",     :default => false, :null => false
  end

  add_index "components", ["reagent_id"], :name => "index_components_on_reagent_id"
  add_index "components", ["type"], :name => "index_components_on_type"

  create_table "items", :force => true do |t|
    t.integer "item_id",                   :null => false
    t.integer "level",                     :null => false
    t.string  "name",                      :null => false
    t.string  "icon",                      :null => false
    t.integer "price",      :default => 0, :null => false
    t.integer "sell_price", :default => 0, :null => false
    t.integer "quality",    :default => 0, :null => false
  end

  add_index "items", ["item_id"], :name => "index_items_on_item_id", :unique => true

  create_table "professions", :force => true do |t|
    t.string "name", :null => false
  end

  add_index "professions", ["name"], :name => "index_professions_on_name", :unique => true

  create_table "reagent_groups", :force => true do |t|
    t.integer "user_id",                                  :null => false
    t.string  "name",                                     :null => false
    t.boolean "include_in_snatch_list", :default => true, :null => false
  end

  add_index "reagent_groups", ["user_id"], :name => "index_reagent_groups_on_user_id"

  create_table "reagents", :force => true do |t|
    t.integer "reagent_group_id", :null => false
    t.integer "item_id",          :null => false
  end

  add_index "reagents", ["item_id"], :name => "index_reagents_on_item_id"
  add_index "reagents", ["reagent_group_id"], :name => "index_reagents_on_reagent_group_id"

  create_table "recipe_groups", :force => true do |t|
    t.integer "profession_id",                                   :null => false
    t.integer "user_id",                                         :null => false
    t.string  "name",                                            :null => false
    t.integer "ah_duration",                   :default => 24,   :null => false
    t.integer "max_restock_quantity",          :default => 5,    :null => false
    t.integer "min_restock_quantity",          :default => 3,    :null => false
    t.integer "post_cap",                      :default => 2,    :null => false
    t.integer "per_auction",                   :default => 1,    :null => false
    t.integer "profit_margin"
    t.integer "fallback_margin"
    t.boolean "create_tsm_groups_for_recipes", :default => true, :null => false
    t.string  "stockpile_character"
  end

  add_index "recipe_groups", ["profession_id"], :name => "index_recipe_groups_on_profession_id"

  create_table "recipe_reagents", :force => true do |t|
    t.integer "recipe_id",                   :null => false
    t.integer "reagent_id",                  :null => false
    t.float   "quantity",   :default => 1.0, :null => false
  end

  add_index "recipe_reagents", ["reagent_id"], :name => "index_recipe_reagents_on_reagent_id"
  add_index "recipe_reagents", ["recipe_id"], :name => "index_recipe_reagents_on_recipe_id"

  create_table "recipes", :force => true do |t|
    t.integer "recipe_group_id", :null => false
    t.integer "item_id",         :null => false
  end

  add_index "recipes", ["item_id"], :name => "index_recipes_on_item_id"
  add_index "recipes", ["recipe_group_id"], :name => "index_recipes_on_recipe_group_id"

  create_table "transformation_reagents", :force => true do |t|
    t.integer "transformation_id",                  :null => false
    t.float   "quantity",          :default => 1.0, :null => false
    t.integer "reagent_id",                         :null => false
  end

  add_index "transformation_reagents", ["transformation_id"], :name => "index_transformation_reagents_on_transformation_id"

  create_table "transformation_yields", :force => true do |t|
    t.integer "transformation_id",                  :null => false
    t.float   "quantity",          :default => 1.0, :null => false
    t.integer "item_id",                            :null => false
  end

  add_index "transformation_yields", ["transformation_id"], :name => "index_transformation_yields_on_transformation_id"

  create_table "transformations", :force => true do |t|
    t.integer "user_id", :null => false
    t.string  "name",    :null => false
  end

  add_index "transformations", ["user_id", "name"], :name => "index_transformations_on_user_id_and_name", :unique => true

  create_table "users", :force => true do |t|
    t.string "email",           :null => false
    t.string "password_digest", :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
