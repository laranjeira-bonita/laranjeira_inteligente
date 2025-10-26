class CreateParticipations < ActiveRecord::Migration[7.1]
  def change
    create_table :participations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :promotion, null: false, foreign_key: true
      t.decimal :used_seconds, precision: 10, scale: 3
      t.decimal :score_points
      t.integer :response
      t.timestamps
    end
  end
end
