require 'base64'
require 'open-uri'
class ShopifyConnection

    def initialize
        shop_url = "https://#{ENV["API_KEY"]}:#{ENV["PASSWORD"]}@#{ENV["SHOP_NAME"]}.myshopify.com"
        ShopifyAPI::Base.site = shop_url
        ShopifyAPI::Base.api_version = '2019-10'
    end
    def self.location
        locations = ShopifyAPI::Location.find(:all)
        locations.first
    end
end
#shopify_product_collection_worker.rb