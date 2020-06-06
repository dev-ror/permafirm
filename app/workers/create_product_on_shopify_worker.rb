require 'rubygems'
class CreateProductOnShopifyWorker
    
  include Sidekiq::Worker
  sidekiq_options :retry => 0

  def perform(product)
    Shopify::ShopifyConnection.connect_to_shop('devstoring.myshopify.com', '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')
    
    new_product = ShopifyAPI::Product.new
    
    new_product.title = 'Test Product'
    new_product.product_type = 'test type'
    new_product.handle = 'Test handle'
    new_product.vendor = 'test vendor'

    # new_product.title = product.title
    # new_product.product_type = product.product_type
    # new_product.handle = product.handle
    # new_product.template_suffix = product.template_suffix
    # new_product.body_html = product.body_html
    # new_product.tags = product.tags
    # new_product.published_scope = product.published_scope
    # new_product.image = product.image
    # new_product.vendor = product.vendor
    # new_product.options = product.options
    # new_product.published_at = product.published_at
    
    new_product.save
  end
end