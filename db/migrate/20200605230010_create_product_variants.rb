class CreateProductVariants < ActiveRecord::Migration[5.2]
  def change
    create_table :product_variants do |t|
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
      t.references :product, foreign_key: true
      t.timestamps
    end
  end
end