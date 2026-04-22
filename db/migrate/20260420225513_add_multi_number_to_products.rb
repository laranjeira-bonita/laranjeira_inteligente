class AddMultiNumberToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :multi_number, :integer, default: 1
  end
end
