class CreateOrderLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_line_items do |t|
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
      t.timestamps
      t.references :order, foreign_key: true
    end
  end
end