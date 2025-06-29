class CreateTickers < ActiveRecord::Migration[7.1]
  def change
    create_table :tickers do |t|
      t.integer :rate
      t.integer :off_type
      t.string :title
      t.references :store
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
