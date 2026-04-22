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

ActiveRecord::Schema[7.1].define(version: 2026_04_21_194833) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.string "title", null: false
    t.integer "person_limit", null: false
    t.datetime "start_at", null: false
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "game_type", default: 0, null: false
  end

  create_table "descriptions", force: :cascade do |t|
    t.string "describable_type", null: false
    t.bigint "describable_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["describable_type", "describable_id"], name: "index_descriptions_on_describable"
  end

  create_table "participations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "promotion_id", null: false
    t.decimal "used_seconds", precision: 10, scale: 3
    t.integer "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nickname"
    t.integer "reward_off_type"
    t.integer "reward_rate"
    t.integer "reward_position"
    t.index ["promotion_id"], name: "index_participations_on_promotion_id"
    t.index ["user_id"], name: "index_participations_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "purchase_id", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.string "payment_method", null: false
    t.string "status", default: "opened", null: false
    t.datetime "paid_at"
    t.string "transaction_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["purchase_id"], name: "index_payments_on_purchase_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.integer "category"
    t.string "description"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "promotion_id"
    t.integer "multi_number", default: 1
    t.index ["promotion_id"], name: "index_products_on_promotion_id"
  end

  create_table "promotions", force: :cascade do |t|
    t.integer "rate"
    t.integer "off_type"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "activity_id", null: false
    t.integer "status", default: 0, null: false
    t.string "result_description"
    t.integer "people_limit"
    t.integer "target_number"
    t.datetime "completed_at"
    t.json "multi_winner", default: []
    t.json "multi_rewards", default: []
    t.index ["activity_id"], name: "index_promotions_on_activity_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.decimal "price"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_id", null: false
    t.integer "state", default: 0, null: false
    t.bigint "ticker_id"
    t.index ["product_id"], name: "index_purchases_on_product_id"
    t.index ["ticker_id"], name: "index_purchases_on_ticker_id"
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "tickers", force: :cascade do |t|
    t.integer "rate"
    t.integer "off_type"
    t.string "title"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "promotion_id", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_tickers_on_deleted_at"
    t.index ["promotion_id"], name: "index_tickers_on_promotion_id"
    t.index ["user_id"], name: "index_tickers_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "transaction_id"
    t.string "qr_code"
    t.string "qr_base64"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "uuid"
    t.string "pix_key"
    t.index ["document_cpf"], name: "index_users_on_document_cpf", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uuid"], name: "index_users_on_uuid", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "participations", "promotions"
  add_foreign_key "participations", "users"
  add_foreign_key "payments", "purchases"
  add_foreign_key "purchases", "products"
  add_foreign_key "purchases", "users"
  add_foreign_key "tickers", "users"
end
