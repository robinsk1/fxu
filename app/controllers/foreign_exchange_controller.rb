class ForeignExchangeController < ApplicationController
  respond_to :json, :html

  #GET
  def index
    @currency_codes = %w[EUR USD JPY BGN CZK DKK GBP HUF PLN RON SEK CHF NOK HRK RUB TRY AUD BRL CAD CNY HKD IDR ILS INR KRW MXN MYR NZD PHP SGD THB ZAR]
  end

  #POST
  def convert
    rate = ExchangeRate.at(params[:date], params[:base_code], params[:counter_code])
    @amount = params[:amount].to_i * rate
    respond_with(@amount.to_json)
  end
end

