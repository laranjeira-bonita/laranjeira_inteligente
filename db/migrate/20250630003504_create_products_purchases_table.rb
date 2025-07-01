class CreateProductsPurchasesTable < ActiveRecord::Migration[7.1]
  def change
    create_table :products_purchases_tables do |t|
      t.references :product, null: false, foreign_key: true
      t.references :purchase, null: false, foreign_key: true
      t.integer :quantity, null: false, default: 1
      t.references :ticker

      t.decimal :total_price, null: false, precision: 10, scale: 2
      t.decimal :paid_amount, null: false, precision: 10, scale: 2
      t.timestamps
    end
  end
end
