class AddGameTypeToActivities < ActiveRecord::Migration[7.1]
  def change
    add_column :activities, :game_type, :integer, null: false, default: 0
    add_column :activities, :result_description, :string
  end
end
