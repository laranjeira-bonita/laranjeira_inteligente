class AddStatusToPromotions < ActiveRecord::Migration[7.1]
  def change
    add_column :promotions, :status, :integer, null: false, default: 0
    add_column :promotions, :result_description, :string
    remove_column :activities, :result_description
  end
end
