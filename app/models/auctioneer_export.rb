class AuctioneerExport < Export

  # Returns the data export in a format ready to be pasted into the in-game
  # addon.
  def data

    reagent_groups = current_user.reagent_groups.for_snatch_list.include_reagents.ordered_by_name.all
    data_lines = [version_line]

    # Add all reagent groups, and all the items within the reagent group.
    reagent_groups.each do |group|

      # Build an array of reagent data for the reagent group.
      reagent_data = []
      group.reagents.each do |reagent|
        reagent_data << format_export_data_set([
          reagent.item.item_id, reagent.production_cost.to_i
        ])
      end

      data_lines << format_export_line([
        group.name, reagent_data
      ].flatten)

    end

    data_lines.join("\n")

  end

  protected

  # Returns the version of the data in this export.
  def export_version
    '1.0.0'
  end

end
