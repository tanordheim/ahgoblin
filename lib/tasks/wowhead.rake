namespace :wowhead do

  # Crawl Wowhead for the item IDS for all glyphs for any given class.
  task :glyph_item_ids, [:class] => :environment do |task, args|

    class_name = args[:class]
    class_id = case class_name
      when 'deathknight' then WowheadClient::CLASS_DEATH_KNIGHT
      when 'druid' then WowheadClient::CLASS_DRUID
      when 'hunter' then WowheadClient::CLASS_HUNTER
      when 'mage' then WowheadClient::CLASS_MAGE
      when 'paladin' then WowheadClient::CLASS_PALADIN
      when 'priest' then WowheadClient::CLASS_PRIEST
      when 'rogue' then WowheadClient::CLASS_ROGUE
      when 'shaman' then WowheadClient::CLASS_SHAMAN
      when 'warlock' then WowheadClient::CLASS_WARLOCK
      when 'warrior' then WowheadClient::CLASS_WARRIOR
      else raise "Invalid class name: #{class_name}"
    end

    wowhead = WowheadClient.new
    item_ids = wowhead.glyph_item_ids(class_id)

    puts "Found #{item_ids.size} item IDs"
    item_ids.each { |id| puts id }

  end

end
