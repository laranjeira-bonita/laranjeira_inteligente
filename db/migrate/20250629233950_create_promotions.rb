class CreatePromotions < ActiveRecord::Migration[7.1]
  def change
    create_table :promotions do |t|
      t.integer :rate
      t.integer :off_type
      t.string :title
      t.references :store
      t.timestamps
    end
  end
end
