class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.string :transaction_id
      t.string :qr_code
      t.string :qr_base64
      t.timestamps
    end
  end
end
