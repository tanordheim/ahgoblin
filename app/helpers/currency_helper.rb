module CurrencyHelper

  # Format a copper value as ingame currency (XgYsZc)
  def format_currency(money)

    money ||= 0
    copper = money % 100
    amount = (money - copper) / 100
    silver = amount % 100
    gold = (amount - silver) / 100

    parts = []
    parts << "#{number_with_delimiter(gold.to_i)}g" if gold > 0
    parts << "#{silver.to_i}s" if silver > 0
    parts << "#{copper.to_i}c" if copper > 0

    parts.join(' ')
    
  end

end
