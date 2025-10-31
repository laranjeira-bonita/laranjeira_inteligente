class AddPeopleLimitToPromotions < ActiveRecord::Migration[7.1]
  def change
    add_column :promotions, :people_limit, :integer
    add_column :promotions, :target_number, :integer
    add_reference :promotions, :winner, foreign_key: { to_table: :users }
  end
end
