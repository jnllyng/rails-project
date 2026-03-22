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

ActiveRecord::Schema[8.1].define(version: 2026_03_22_011833) do
  create_table "addresses", force: :cascade do |t|
    t.string "city"
    t.datetime "created_at", null: false
    t.string "postal_code"
    t.integer "province_id", null: false
    t.string "street"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["province_id"], name: "index_addresses_on_province_id"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.decimal "item_price"
    t.integer "order_id", null: false
    t.integer "product_id", null: false
    t.integer "quantity"
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "address_id", null: false
    t.datetime "created_at", null: false
    t.decimal "gst_rate"
    t.decimal "hst_rate"
    t.integer "province_id", null: false
    t.decimal "pst_rate"
    t.string "status"
    t.decimal "total"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["address_id"], name: "index_orders_on_address_id"
    t.index ["province_id"], name: "index_orders_on_province_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.string "image"
    t.string "name"
    t.decimal "price"
    t.integer "stock"
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "provinces", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.decimal "gst"
    t.decimal "hst"
    t.string "name"
    t.decimal "pst"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "password"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "addresses", "provinces"
  add_foreign_key "addresses", "users"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "orders", "addresses"
  add_foreign_key "orders", "provinces"
  add_foreign_key "orders", "users"
  add_foreign_key "products", "categories"
end
