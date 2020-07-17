require 'rubygems'
require 'shopify_api'
require 'shopify_product_collection_worker'
class OrderWorker

  JOB_NAME = "OrderJob"

  include Sidekiq::Worker
  sidekiq_options :retry => 5

  #sidekiq_options backtrace: true
  #
  #sidekiq_retries_exhausted do |ctx, ex|
  #  Sidekiq.logger.warn "Failed #{ctx['class']} with #{ctx['args']}: #{ctx['error_message']}"
  #  ErrorService.notify(ex,ctx)
  #end

  def perform()
    # Order.destroy_all

    ShopifyConnection.new
    orders = ShopifyAPI::Order.where(created_at_min:"2019-01-01", params: { limit: 1 })
    process_orders(orders)
    #while orders.next_page?
    #  orders = orders.fetch_next_page
    #  process_orders(orders)
    #end

  end
  def process_orders orders
    orders.each do |order|
      name = order.name
      order_detail = order.note
      source = order.source_name
      tracking_id = ''
      status = order.financial_status
      price =  order.total_line_items_price
      customer_name = "#{order.customer.first_name}#{orders.customer.last_name}" rescue ""
      details = order
      shopify_order = Order.create(name: name, order_detail: order_detail, source: source, tracking_id: tracking_id, status: status, price: price, customer_name: customer_name, details: details)
      line_items = order.line_items
      order_date = order.created_at.to_date
      if line_items.present?
        line_items.each do |list_item|
          item_id = list_item.id
          varient_id = list_item.variant_id
          title = list_item.title
          quantity =  list_item.quantity
          sku = list_item.sku
          varient_title = list_item.variant_id
          vendor = list_item.vendor
          fulfilment_service =  list_item.fulfillment_service
          product_id = list_item.product_id
          gift_card = list_item.gift_card
          name = list_item.name
          price =  list_item.price
          total_discount =  list_item.total_discount
          #customer_name =  list_item.first.origin_location.name
          #customer_address1 = list_item.first.origin_location.address1
          #customer_address2 = list_item.first.origin_location.address2
          #customer_city = list_item.first.origin_location.city
          #customer_country = list_item.first.origin_location.country_code
          #customer_zip = list_item.first.origin_location.zip
          shopify_order.order_line_items.create(item_id: item_id,
                               varient_id: varient_id,
                               title: title,
                               quantity: quantity,
                               sku: sku,
                               varient_title: varient_title,
                               vendor: vendor,
                               fulfilment_service: fulfilment_service,
                               product_id: product_id,
                               gift_card: gift_card,
                               name:name,
                               price: price,
                               total_discount:total_discount,
                               order_details: list_item)
        end
      end
      wait_for_shopify_credits
    end
  end
  def wait_for_shopify_credits
    if ShopifyAPI::credit_left < 4
      puts "sleeping for 10 seconds to obtain credits..."
      sleep(10)
    else
      puts "credit limit left #{ShopifyAPI::credit_left}"
    end
  end
end