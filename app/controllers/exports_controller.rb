class ExportsController < ApplicationController

  respond_to :html, :js
  expose(:auctioneer_export) { AuctioneerExport.new(current_user) }
  expose(:tradeskillmaster_export) { TradeskillMasterExport.new(current_user) }

  # GET /exports
  #
  # Displays a list of the available data exports.
  def index
  end

  # GET /exports/auctioneer
  #
  # Exports Auctioneer snatch list data.
  def auctioneer
  end

  # GET /exports/tradeskillmaster
  #
  # Exports TradeSkillMaster craft list and groups.
  def tradeskillmaster
  end

end
