class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :category
      t.string :description
      t.decimal :price
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
  end
end
