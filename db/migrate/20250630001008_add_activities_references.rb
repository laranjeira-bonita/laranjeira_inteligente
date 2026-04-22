class AddActivitiesReferences < ActiveRecord::Migration[7.1]
  def change
    add_reference :promotions, :activity, null: false
    add_reference :tickers, :promotion, null: false
    add_reference :products, :promotion
  end
end