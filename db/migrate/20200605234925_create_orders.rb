class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string "name"
      t.text "order_detail"
      t.string "source"
      t.string "tracking_id"
      t.integer "status"
      t.decimal "price"
      t.string "customer_name"
      t.jsonb "details", default: "{}"
      t.index ["details"], name: "index_orders_on_details", using: :gin
      t.timestamps
    end
  end
end