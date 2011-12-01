class WowheadClient

  # Define some Wowhead IDs.
  CLASS_DEATH_KNIGHT = 6
  CLASS_DRUID = 11
  CLASS_HUNTER = 3
  CLASS_MAGE = 8
  CLASS_PALADIN = 2
  CLASS_PRIEST = 5
  CLASS_ROGUE = 4
  CLASS_SHAMAN = 7
  CLASS_WARLOCK = 9
  CLASS_WARRIOR = 1

  # Define the HTTP user agent.
  USER_AGENT = 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.1) Gecko/20060111 Firefox/1.5.0.1'

  # Initialize the Wowhead client.
  def initialize
    @http = Net::HTTP.new('www.wowhead.com', 80)
  end

  # Fetch an array of item IDs for each of the available glyphs for the
  # specified class.
  def glyph_item_ids(class_id)

    item_ids = []
    body = wowhead_request("/items=16.#{class_id}")

    if body =~ /(_\[\d+\]=\{name_enus\:.+\}\;)/

      glyph_definitions = $1.split(';')
      glyph_definitions.each do |glyph|
        glyph.scan(/_\[(\d+)\]=/) do |item_id|
          item_ids << item_id
        end
      end

    end

    item_ids

  end

  private

  # Return the body of a request to Wowhead.
  def wowhead_request(uri)

    headers = {
      'Referer' => 'http://www.wowhead.com/',
      'User-Agent' => USER_AGENT
    }
    response = @http.get(uri, headers)
    response.body

  end

end
