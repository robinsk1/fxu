desc "update exchange rates from XML feed"
task :update_exchange_rates => :environment do
  require "#{Rails.root}/lib/exchange_rate/data_source_fetcher.rb"

  if ExchangeRate::DataSourceFetcher.update_rates
    puts 'currency_rates updated'
  else
    puts 'currency_rates update failed'
  end
end
