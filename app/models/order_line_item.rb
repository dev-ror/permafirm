class OrderLineItem < ApplicationRecord
    belongs_to :order
    belongs_to :product_variant, class_name: 'ProductVariant', foreign_key: 'variant_id', primary_key: "variant_id", optional: true
end
