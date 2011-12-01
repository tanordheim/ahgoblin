# encoding: utf-8

# Clear the data in the database
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

# Create a user.
user = User.create!(:email => 't@binarymarbles.com', :password => 'password')

# Create some extra users without data.
User.create!(:email => 'm@binarymarbles.com', :password => 'password')

# Create some items.
silver_rod = Item.find_or_load(6338)
silver_bar = Item.find_or_load(2842)
silver_ore = Item.find_or_load(2775)
rough_grinding_stone = Item.find_or_load(3470)
rough_stone = Item.find_or_load(2835)
enchant_bracer_major_stamina = Item.find_or_load(44947)
greater_cosmic_essence = Item.find_or_load(34055)
abyss_crystal = Item.find_or_load(34057)
infinite_dust = Item.find_or_load(34054)
enchanting_vellum = Item.find_or_load(38682)
enchant_bracer_major_stamina = Item.find_or_load(44947)

# Create some reagent groups.
mineral_group = ReagentGroup.create!(:name => 'Minerals', :user => user)
vendor_mats_group = ReagentGroup.create!(:name => 'Vendor Mats', :include_in_snatch_list => false, :user => user)
enchanting_mats_group = ReagentGroup.create!(:name => 'Enchanting Mats', :user => user)

# Create some basic reagents.
silver_ore_reg = Reagent.new(:reagent_group => mineral_group, :item => silver_ore)
silver_ore_reg.item_components.build(:item => silver_ore, :quantity => 1, :price => 30000)
silver_ore_reg.save!
rough_stone_reg = Reagent.new(:reagent_group => mineral_group, :item => rough_stone)
rough_stone_reg.item_components.build(:item => rough_stone, :quantity => 1, :price => 1000)
rough_stone_reg.save!
abyss_crystal_reg = Reagent.new(:reagent_group => enchanting_mats_group, :item => abyss_crystal)
abyss_crystal_reg.item_components.build(:item => abyss_crystal, :quantity => 1, :price => 300000)
abyss_crystal_reg.save!
enchanting_vellum_reg = Reagent.new(:reagent_group => vendor_mats_group, :item => enchanting_vellum)
enchanting_vellum_reg.item_components.build(:item => enchanting_vellum, :quantity => 1, :use_vendor_price => true)
enchanting_vellum_reg.save!

# Create some crafted reagents.
silver_bar_reg = Reagent.new(:reagent_group => mineral_group, :item => silver_bar)
silver_bar_reg.reagent_components.build(:reagent_reference => silver_ore_reg, :quantity => 2)
silver_bar_reg.save!
rough_grinding_stone_reg = Reagent.new(:reagent_group => mineral_group, :item => rough_grinding_stone)
rough_grinding_stone_reg.reagent_components.build(:reagent_reference => rough_stone_reg, :quantity => 2)
rough_grinding_stone_reg.save!

# Create some transformations.
abyss_shatter = Transformation.new(:name => 'Enchanting: Abyss Shatter', :user => user)
abyss_shatter.reagents.build(:reagent => abyss_crystal_reg, :quantity => 1)
abyss_shatter.yields.build(:item => greater_cosmic_essence, :quantity => 1.95)
abyss_shatter.yields.build(:item => infinite_dust, :quantity => 4.57)
abyss_shatter.save!

# Create some items based on transformations.
greater_cosmic_essence_reg = Reagent.new(:reagent_group => enchanting_mats_group, :item => greater_cosmic_essence)
greater_cosmic_essence_reg.transformation_components.build(:transformation => abyss_shatter)
greater_cosmic_essence_reg.save!
infinite_dust_reg = Reagent.new(:reagent_group => enchanting_mats_group, :item => infinite_dust)
infinite_dust_reg.transformation_components.build(:transformation => abyss_shatter)
infinite_dust_reg.save!

# Create the professions.
alchemy = Profession.create!(:name => 'Alchemy')
blacksmithing = Profession.create!(:name => 'Blacksmithing')
cooking = Profession.create!(:name => 'Cooking')
enchanting = Profession.create!(:name => 'Enchanting')
engineering = Profession.create!(:name => 'Engineering')
inscription = Profession.create!(:name => 'Inscription')
jewelcrafting = Profession.create!(:name => 'Jewelcrafting')
leatherworking = Profession.create!(:name => 'Leatherworking')
mining = Profession.create!(:name => 'Mining')
tailoring = Profession.create!(:name => 'Tailoring')

# Create some recipe groups.
enchants_group = RecipeGroup.create!(:name => 'Wrist enchants', :profession => enchanting, :user => user)
rods_group = RecipeGroup.create!(:name => 'Enchanting rods', :profession => blacksmithing, :user => user)

# Create some recipes.
enchant_bracer_major_stamina_recipe = Recipe.new(:item => enchant_bracer_major_stamina, :recipe_group => enchants_group)
enchant_bracer_major_stamina_recipe.reagents.build(:reagent => abyss_crystal_reg, :quantity => 1)
enchant_bracer_major_stamina_recipe.reagents.build(:reagent => greater_cosmic_essence_reg, :quantity => 4)
enchant_bracer_major_stamina_recipe.save!
silver_rod_recipe = Recipe.new(:item => silver_rod, :recipe_group => rods_group)
silver_rod_recipe.reagents.build(:reagent => silver_bar_reg, :quantity => 1)
silver_rod_recipe.reagents.build(:reagent => rough_grinding_stone_reg, :quantity => 2)
silver_rod_recipe.save!
