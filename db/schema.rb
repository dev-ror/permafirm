# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_17_130433) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "order_line_items", force: :cascade do |t|
    t.bigint "variant_id"
    t.string "title"
    t.integer "quantity"
    t.string "sku"
    t.string "vendor"
    t.string "fulfilment_service"
    t.bigint "product_id"
    t.boolean "gift_card"
    t.string "name"
    t.string "price"
    t.string "total_discount"
    t.string "customer_name"
    t.string "customer_address1"
    t.string "customer_address2"
    t.string "customer_city"
    t.string "customer_country"
    t.string "customer_zip"
    t.jsonb "order_details"
    t.bigint "order_id"
    t.bigint "item_id"
    t.string "order_number"
    t.string "tags"
    t.integer "status"
    t.string "order_name"
    t.datetime "order_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_line_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "name"
    t.text "order_detail"
    t.string "source"
    t.string "tracking_id"
    t.integer "status"
    t.decimal "price"
    t.string "customer_name"
    t.jsonb "details", default: "{}"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["details"], name: "index_orders_on_details", using: :gin
  end

  create_table "product_variants", force: :cascade do |t|
    t.bigint "variant_id"
    t.string "variant_title"
    t.decimal "price"
    t.string "sku"
    t.integer "position"
    t.string "inventory_policy"
    t.decimal "compare_at_price"
    t.string "fulfillment_service"
    t.string "inventory_management"
    t.string "option1"
    t.string "option2"
    t.string "option3"
    t.boolean "taxable"
    t.string "barcode"
    t.decimal "weight"
    t.string "weight_unit"
    t.integer "inventory_quantity"
    t.bigint "image_id"
    t.integer "grams"
    t.bigint "inventory_item_id"
    t.string "tax_code"
    t.integer "old_inventory_quantity"
    t.boolean "requires_shipping"
    t.bigint "shopify_product_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "product_vendor"
    t.index ["product_id"], name: "index_product_variants_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.string "product_type"
    t.string "handle"
    t.string "template_suffix"
    t.text "body_html"
    t.string "tags"
    t.string "published_scope"
    t.jsonb "image"
    t.string "vendor"
    t.jsonb "options"
    t.datetime "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shops", force: :cascade do |t|
    t.string "shopify_domain", null: false
    t.string "shopify_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shopify_domain"], name: "index_shops_on_shopify_domain", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "order_line_items", "orders"
  add_foreign_key "product_variants", "products"
end
