# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_06_30_014709) do
  create_table "activities", force: :cascade do |t|
    t.string "title", null: false
    t.integer "person_limit", null: false
    t.datetime "start_at", null: false
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "activities_users", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "activity_id", null: false
    t.decimal "used_seconds", precision: 10, scale: 3
    t.decimal "score_points"
    t.integer "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_activities_users_on_activity_id"
    t.index ["user_id"], name: "index_activities_users_on_user_id"
  end

  create_table "descriptions", force: :cascade do |t|
    t.string "describable_type", null: false
    t.integer "describable_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["describable_type", "describable_id"], name: "index_descriptions_on_describable"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.integer "category"
    t.string "description"
    t.decimal "price"
    t.integer "store_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "promotion_id"
    t.index ["promotion_id"], name: "index_products_on_promotion_id"
    t.index ["store_id"], name: "index_products_on_store_id"
  end

  create_table "products_purchases_tables", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "purchase_id", null: false
    t.integer "quantity", default: 1, null: false
    t.integer "ticker_id"
    t.decimal "total_price", precision: 10, scale: 2, null: false
    t.decimal "paid_amount", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_products_purchases_tables_on_product_id"
    t.index ["purchase_id"], name: "index_products_purchases_tables_on_purchase_id"
    t.index ["ticker_id"], name: "index_products_purchases_tables_on_ticker_id"
  end

  create_table "promotions", force: :cascade do |t|
    t.integer "rate"
    t.integer "off_type"
    t.string "title"
    t.integer "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "activity_id", null: false
    t.index ["activity_id"], name: "index_promotions_on_activity_id"
    t.index ["store_id"], name: "index_promotions_on_store_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.decimal "price"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "name"
    t.string "document_cnpj"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_stores_on_user_id"
  end

  create_table "tickers", force: :cascade do |t|
    t.integer "rate"
    t.integer "off_type"
    t.string "title"
    t.integer "store_id"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "promotion_id", null: false
    t.index ["promotion_id"], name: "index_tickers_on_promotion_id"
    t.index ["store_id"], name: "index_tickers_on_store_id"
    t.index ["user_id"], name: "index_tickers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "document_cpf"
    t.string "full_name"
    t.string "phone_number"
    t.string "nickname"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "last_sign_in_ip"
    t.datetime "blocked_at"
    t.index ["document_cpf"], name: "index_users_on_document_cpf", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "activities_users", "activities"
  add_foreign_key "activities_users", "users"
  add_foreign_key "products", "stores"
  add_foreign_key "products_purchases_tables", "products"
  add_foreign_key "products_purchases_tables", "purchases"
  add_foreign_key "purchases", "users"
  add_foreign_key "tickers", "users"
end
