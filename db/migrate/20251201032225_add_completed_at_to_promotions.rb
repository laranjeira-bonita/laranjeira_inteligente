class AddCompletedAtToPromotions < ActiveRecord::Migration[7.1]
  def change
    add_column :promotions, :completed_at, :datetime
  end
end
