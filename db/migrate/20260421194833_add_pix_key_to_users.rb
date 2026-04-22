class AddPixKeyToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :pix_key, :string
  end
end
