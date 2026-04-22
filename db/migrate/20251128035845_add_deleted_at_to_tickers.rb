class AddDeletedAtToTickers < ActiveRecord::Migration[7.1]
  def change
    add_column :tickers, :deleted_at, :datetime
    add_index :tickers, :deleted_at
  end
end
