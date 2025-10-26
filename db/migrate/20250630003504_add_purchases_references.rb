class AddPurchasesReferences < ActiveRecord::Migration[7.1]
  def change
    add_reference :purchases, :product, null: false, foreign_key: true
    add_column :purchases, :state, :integer, null: false, default: 0
  end
end
