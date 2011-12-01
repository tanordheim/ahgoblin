class TradeskillMasterExport < Export

  # Returns the data export in a format ready to be pasted into the in-game
  # addon.
  def data

    professions = Profession.includes(:recipe_groups).all
    recipes = Recipe.for_user(current_user).include_item.include_reagents.include_group.ordered_by_name.all
    auto_mail_characters = current_user.auto_mail_characters.include_items.ordered_by_name.all
    data_lines = [version_line]

    # Add category definitions.
    professions.each do |profession|

      # Build an array of groups for each profession.
      category_data = []
      profession.recipe_groups.for_user(current_user).ordered_by_name.each do |group|
        category_data << category_name(group)
      end

      unless category_data.empty?
        data_lines << format_export_line([
          'category', category_data
        ].flatten)
      end

    end

    # Add recipe definitions.
    recipes.each do |recipe|

      stockpile_character = recipe.recipe_group.stockpile_character.blank? ? '-' : recipe.recipe_group.stockpile_character

      data_lines << format_export_line([
        'item', category_name(recipe.recipe_group), recipe.recipe_group.profession.name, stockpile_character,
        recipe.item.item_id, recipe.minimum_price.to_i, recipe.fallback_price.to_i, recipe.recipe_group.max_restock_quantity,
        recipe.recipe_group.min_restock_quantity, recipe.recipe_group.post_cap, recipe.recipe_group.per_auction
      ])

    end

    # Add auto-mail definitions.
    auto_mail_characters.each do |character|

      item_ids = character.auto_mail_items.map { |i| i.item.item_id }
      data_lines << format_export_line([
        'automail', character.name, item_ids
      ])

    end

    data_lines.join("\n")

  end

  protected

  # Returns the version of the data in this export.
  def export_version
    '1.0.0'
  end

  # Returns the category name of the specified recipe group.
  def category_name(recipe_group)
    "#{recipe_group.profession.name} - #{recipe_group.name}".downcase
  end

end
