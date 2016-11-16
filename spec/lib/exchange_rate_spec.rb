require 'spec_helper'

describe ExchangeRate do
  let(:date) { '23/8/16' }
  let(:eur) { 'EUR' }
  let(:usd) { 'USD' }
  let(:usd_to_eur) { 1.66 }

  before :each do
    FactoryGirl.create(:currency_rate, rate: usd_to_eur, currency_code: usd, rate_calculated_date: date)
  end

  describe 'at' do
    it 'returns 1 if base_currency and counter_currency code are the same' do
      result = ExchangeRate.at(date, usd, usd)
      expect(result).to eq(1)
    end

    context 'base currency is EUR' do
      it 'returns correct exchange rate' do
        result = ExchangeRate.at(date, eur, usd)
        expect(result).to eq(1.66)
      end
    end

    context 'base currency other than EUR' do
      it 'returns correct exchange rate' do
        result = ExchangeRate.at(date, usd, eur)
        expect(result).to eq(0.6024096385542169)
      end
    end
  end

end
