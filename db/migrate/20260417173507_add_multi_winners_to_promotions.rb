class AddMultiWinnersToPromotions < ActiveRecord::Migration[7.1]
  def change
    add_column :promotions, :multi_winner, :json, default: []
    add_column :promotions, :multi_rewards, :json, default: []
    
    add_column :participations, :reward_off_type, :integer
    add_column :participations, :reward_rate, :integer
    add_column :participations, :reward_position, :integer

    
    remove_index :promotions, :winner_id
    remove_column :participations, :score_points
    remove_column :promotions, :winner_id    
  end
end
