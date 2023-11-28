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

ActiveRecord::Schema[7.0].define(version: 2023_11_28_180231) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.uuid "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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

  create_table "active_storage_variant_records", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "ai_results", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "kind"
    t.text "input_text"
    t.text "output_text"
    t.text "api_response"
    t.uuid "business_id"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_ai_results_on_business_id"
    t.index ["user_id"], name: "index_ai_results_on_user_id"
  end

  create_table "banks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "business_approval_histories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "business_id", null: false
    t.string "status"
    t.text "client_remark"
    t.text "system_remark"
    t.boolean "resolved", default: false, null: false
    t.uuid "requested_by_id"
    t.uuid "managed_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_business_approval_histories_on_business_id"
    t.index ["managed_by_id"], name: "index_business_approval_histories_on_managed_by_id"
    t.index ["requested_by_id"], name: "index_business_approval_histories_on_requested_by_id"
  end

  create_table "business_banks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "bank_id", null: false
    t.uuid "business_id", null: false
    t.string "full_name"
    t.string "account_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bank_id", "account_number"], name: "index_business_banks_on_bank_id_and_account_number", unique: true
    t.index ["bank_id"], name: "index_business_banks_on_bank_id"
    t.index ["business_id"], name: "index_business_banks_on_business_id"
  end

  create_table "business_customers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "business_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_business_customers_on_business_id"
    t.index ["user_id"], name: "index_business_customers_on_user_id"
  end

  create_table "business_products", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.uuid "business_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_business_products_on_business_id"
  end

  create_table "business_rewards", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "kind"
    t.float "value"
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id", null: false
    t.boolean "is_active"
    t.datetime "deactivated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "business_id"
    t.string "value_type"
    t.float "capped_amount"
    t.float "min_order_amount"
    t.index ["business_id"], name: "index_business_rewards_on_business_id"
    t.index ["created_by_id"], name: "index_business_rewards_on_created_by_id"
    t.index ["kind", "business_id"], name: "index_business_rewards_on_kind_and_business_id", unique: true
    t.index ["updated_by_id"], name: "index_business_rewards_on_updated_by_id"
  end

  create_table "business_statistics", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "business_id", null: false
    t.integer "total_regular"
    t.integer "total_customer"
    t.float "regular_rating_average"
    t.float "customer_rating_average"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_business_statistics_on_business_id"
  end

  create_table "business_subscriptions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "stripe_subscription_id"
    t.uuid "business_id", null: false
    t.string "status"
    t.string "plan"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_business_subscriptions_on_business_id"
  end

  create_table "business_token_consumptions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "kind"
    t.uuid "business_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_business_token_consumptions_on_business_id"
  end

  create_table "business_token_limits", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "kind"
    t.integer "limit"
    t.string "limit_by"
    t.uuid "business_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_business_token_limits_on_business_id"
  end

  create_table "businesses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "registration_id"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "city"
    t.string "state"
    t.string "postcode"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "approved_at", precision: nil
    t.string "gmap_link"
    t.time "open_at"
    t.time "close_at"
    t.string "status", default: "new"
    t.string "category"
  end

  create_table "cities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "state_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "countries", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customer_check_ins", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "business_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_customer_check_ins_on_business_id"
    t.index ["user_id"], name: "index_customer_check_ins_on_user_id"
  end

  create_table "customer_progresses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "business_id", null: false
    t.float "rating_average", default: 0.0, null: false
    t.integer "rating_count", default: 0, null: false
    t.integer "rating_pending", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "experience", default: 0
    t.integer "level", default: 0
    t.integer "check_in_count", default: 0
    t.index ["business_id"], name: "index_customer_progresses_on_business_id"
    t.index ["user_id"], name: "index_customer_progresses_on_user_id"
  end

  create_table "customer_rewards", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "kind"
    t.float "value"
    t.datetime "given_at"
    t.datetime "claimed_at"
    t.integer "likeness"
    t.uuid "business_reward_id", null: false
    t.uuid "business_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id"
    t.string "value_type"
    t.float "min_order_amount"
    t.float "capped_amount"
    t.uuid "qr_code_id"
    t.index ["business_id"], name: "index_customer_rewards_on_business_id"
    t.index ["business_reward_id"], name: "index_customer_rewards_on_business_reward_id"
    t.index ["qr_code_id"], name: "index_customer_rewards_on_qr_code_id"
    t.index ["user_id"], name: "index_customer_rewards_on_user_id"
  end

  create_table "events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "omniauths", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "provider", null: false
    t.string "uid", null: false
    t.text "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id"
    t.string "user_type"
    t.index ["provider", "uid", "user_id"], name: "index_omniauths_on_provider_and_uid_and_user_id", unique: true
    t.index ["user_id"], name: "index_omniauths_on_user_id"
  end

  create_table "progresses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "type"
    t.string "progress_type"
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_progresses_on_user_id"
  end

  create_table "push_subscriptions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "endpoint"
    t.string "p256dh"
    t.string "auth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.string "type"
    t.index ["p256dh", "auth", "user_id", "type"], name: "index_push_subscriptions_on_p256dh_auth_user_id_type", unique: true
    t.index ["user_id"], name: "index_push_subscriptions_on_user_id"
  end

  create_table "qr_codes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "type"
    t.integer "scanned_times", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "business_id"
    t.index ["business_id"], name: "index_qr_codes_on_business_id"
  end

  create_table "reviews", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "rating"
    t.text "description"
    t.uuid "business_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id"
    t.uuid "qr_code_id"
    t.index ["business_id"], name: "index_reviews_on_business_id"
    t.index ["qr_code_id"], name: "index_reviews_on_qr_code_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "states", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "country_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_states_on_country_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", default: ""
    t.string "last_name", default: ""
    t.string "role", default: "anonymous"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "business_id"
    t.string "type"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.uuid "invited_by_id"
    t.index ["business_id"], name: "index_users_on_business_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email", "type"], name: "index_users_on_email_and_type", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "ai_results", "businesses"
  add_foreign_key "ai_results", "users"
  add_foreign_key "business_approval_histories", "businesses"
  add_foreign_key "business_approval_histories", "users", column: "managed_by_id"
  add_foreign_key "business_approval_histories", "users", column: "requested_by_id"
  add_foreign_key "business_banks", "banks"
  add_foreign_key "business_banks", "businesses"
  add_foreign_key "business_customers", "businesses"
  add_foreign_key "business_customers", "users"
  add_foreign_key "business_products", "businesses"
  add_foreign_key "business_rewards", "businesses"
  add_foreign_key "business_rewards", "users", column: "created_by_id"
  add_foreign_key "business_rewards", "users", column: "updated_by_id"
  add_foreign_key "business_statistics", "businesses"
  add_foreign_key "business_subscriptions", "businesses"
  add_foreign_key "business_token_consumptions", "businesses"
  add_foreign_key "business_token_limits", "businesses"
  add_foreign_key "cities", "states"
  add_foreign_key "customer_check_ins", "businesses"
  add_foreign_key "customer_check_ins", "users"
  add_foreign_key "customer_progresses", "businesses"
  add_foreign_key "customer_progresses", "users"
  add_foreign_key "customer_rewards", "business_rewards"
  add_foreign_key "customer_rewards", "businesses"
  add_foreign_key "customer_rewards", "qr_codes"
  add_foreign_key "customer_rewards", "users"
  add_foreign_key "omniauths", "users"
  add_foreign_key "progresses", "users"
  add_foreign_key "push_subscriptions", "users"
  add_foreign_key "qr_codes", "businesses"
  add_foreign_key "reviews", "businesses"
  add_foreign_key "reviews", "qr_codes"
  add_foreign_key "reviews", "users"
  add_foreign_key "states", "countries"
  add_foreign_key "users", "businesses"
end
