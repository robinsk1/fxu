class ExchangeRate

  class << self

    def at(date, base, counter)
      return 1 if base == counter
      if base == 'EUR'
        currency_rate(date, counter)
      else
        (1/currency_rate(date, base)) * currency_rate(date, counter)
      end
    end

    private

    def currency_rate(date, code)
      code == 'EUR' ? 1 : CurrencyRate.where(rate_calculated_date: date, currency_code: code ).select(:rate).first.rate.to_f
    end
  end

end
