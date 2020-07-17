class AddProductVendorToProductVariant < ActiveRecord::Migration[5.2]
  def change
    add_column :product_variants, :product_vendor, :string
  end
end
