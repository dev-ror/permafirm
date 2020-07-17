class AddTitleToProductVariant < ActiveRecord::Migration[5.2]
  def change
    add_column :product_variants, :title, :string
  end
end
