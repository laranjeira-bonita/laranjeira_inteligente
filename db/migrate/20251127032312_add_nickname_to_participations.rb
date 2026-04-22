class AddNicknameToParticipations < ActiveRecord::Migration[7.1]
  def change
    add_column :participations, :nickname, :string
  end
end
