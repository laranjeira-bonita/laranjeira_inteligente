class AddTickerIdToPurchases < ActiveRecord::Migration[7.1]
  def change
    add_reference :purchases, :ticker
  end
end
