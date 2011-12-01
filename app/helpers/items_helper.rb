module ItemsHelper

  # Returns the identifier of the quality for the specified item.
  def item_quality_identifier(item)
    case item.quality
      when Item::QUALITY_COMMON then 'common'
      when Item::QUALITY_UNCOMMON then 'uncommon'
      when Item::QUALITY_RARE then 'rare'
      when Item::QUALITY_EPIC then 'epic'
      when Item::QUALITY_LEGENDARY then 'legendary'
      when Item::QUALITY_ARTIFACT then 'artifact'
      when Item::QUALITY_HEIRLOOM then 'heirloom'
      else 'poor'
    end
  end

  # Returns the class to apply to item references.
  def item_class(item)
    quality_class = "quality-#{item_quality_identifier(item)}"
    ['label', 'item', quality_class].join(' ')
  end

  # Returns the URL to the icon of the specified item.
  def item_icon_url(item)
    "http://wow.zamimg.com/images/wow/icons/small/#{item.icon}.jpg"
  end

  # Display an item.
  def display_item(item)

    icon_overlay = content_tag(:span, '', :class => 'icon-frame')
    icon = content_tag(:span, image_tag(item_icon_url(item)) + icon_overlay, :class => 'item-icon')
    text = content_tag(:span, item.name, :class => item_class(item))

    content_tag(:span, icon + text, :class => 'item-container')

  end

end
