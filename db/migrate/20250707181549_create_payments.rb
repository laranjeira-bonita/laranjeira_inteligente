class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.references :purchase, null: false, foreign_key: true
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.string :payment_method, null: false
      t.string :status, null: false, default: "opened"
      t.datetime :paid_at
      t.string :transaction_id, null: false
      t.timestamps
    end
  end
end
