class CreateActivities < ActiveRecord::Migration[7.1]
  def change
    create_table :activities do |t|
      t.string :title, null: false
      t.integer :person_limit, null: false
      t.datetime :start_at, null: false
      t.datetime :end_at
      t.timestamps
    end
  end
end
