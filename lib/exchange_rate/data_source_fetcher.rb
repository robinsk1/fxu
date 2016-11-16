require 'net/http'

class ExchangeRate::DataSourceFetcher

  CURRENCY_EXCHANGE_URL = URI.parse('http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml')

  class << self
    def update_rates
      get_data
    end

    private

    def get_data
      begin
        response = Net::HTTP.get(CURRENCY_EXCHANGE_URL)
      rescue StandardError
        Rails.logger.error("Currency Exchange data could not be retrieved")
        false
      end

      refresh_exchange_rates(parse_xml(response))
    end

    def refresh_exchange_rates(response_hash)
      ::CurrencyRate.delete_all
      response_hash['Envelope']['Cube']['Cube'].each do | day |
        day['Cube'].each do | rate |
          exchange_rate = ::CurrencyRate.new
          exchange_rate.rate_calculated_date = day['time']
          exchange_rate.rate = rate['rate']
          exchange_rate.currency_code = rate['currency']
          exchange_rate.save!
        end
      end
    end

    def parse_xml(response)
      Hash.from_xml(response)
    end

  end

end
