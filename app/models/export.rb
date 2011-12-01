class Export

  # Initialize the export class.
  def initialize(user)
    @current_user = user
  end

  protected

  # Formats a line in the data export format.
  def format_export_line(data)
    data.join('|')
  end

  # Format a data set embedded within a line in the data export format.
  def format_export_data_set(data)
    data.join(';')
  end

  # Returns the version line for this Auctioneer export.
  def version_line
    format_export_line(['version', export_version])
  end

  # Returns the user that the export is generated for.
  def current_user
    @current_user
  end
  
end
