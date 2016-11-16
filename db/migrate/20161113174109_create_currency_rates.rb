class CreateCurrencyRates < ActiveRecord::Migration
  def change
    create_table :currency_rates do |t|
      t.string :currency_code
      t.decimal :rate
      t.date :rate_calculated_date

      t.timestamps null: false
    end
  end
end
