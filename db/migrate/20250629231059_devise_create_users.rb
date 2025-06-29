# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :document_cpf
      t.string :full_name
      t.string :phone_number
      t.string :nickname
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.string   :last_sign_in_ip
      t.datetime :blocked_at, default: nil
    end

    add_index :users, :email,           unique: true
    add_index :users, :document_cpf,         unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
