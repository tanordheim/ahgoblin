namespace :items do

  # Refresh all items in the database from the Battle.net Community API.
  task :refresh => :environment do
    Item.all.each(&:refresh_from_api)
    puts "#{Item.count} items refreshed from the Battle.net Community API"
  end

end
