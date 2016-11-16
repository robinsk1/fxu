require 'rails_helper'

RSpec.describe ForeignExchangeController, type: :controller do

  let(:date) { '23/8/16' }
  let(:eur) { 'EUR' }
  let(:usd) { 'USD' }
  let(:usd_to_eur) { '1.0904' }

  before :each do
    FactoryGirl.create(:currency_rate, rate: usd_to_eur, currency_code: usd, rate_calculated_date: date)
  end

  describe "GET #index" do

    it "returns http success" do
      get :index
      expect(assigns[:currency_codes]).to eq %w[EUR USD JPY BGN CZK DKK GBP HUF PLN RON SEK CHF NOK HRK RUB TRY AUD BRL CAD CNY HKD IDR ILS INR KRW MXN MYR NZD PHP SGD THB ZAR]
      expect(response).to have_http_status(:success)
    end

  end

  describe "GET #convert" do

    it "returns JSON object with amount" do
      get :convert, amount: '100', date: date, base_code: eur, counter_code: usd, format: :json
      expect(response.body).to eq '109.04'
    end

  end

end
