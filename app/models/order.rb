class Order < ApplicationRecord
    has_many :order_line_items, dependent: :destroy
end
