class CreateDescriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :descriptions do |t|
      t.references :describable, polymorphic: true, null: false
      t.text :content
      t.timestamps
    end
  end
end
