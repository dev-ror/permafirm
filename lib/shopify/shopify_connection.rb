module Shopify::ShopifyConnection
    def self.connect_to_shop(domain, token)
        shopify_session = ShopifyAPI::Session.new(domain: domain,api_version: ENV['API_VERSION'],token: token)
        
        ShopifyAPI::Base.activate_session(shopify_session)
        
    end
    def self.location
        locations = ShopifyAPI::Location.find(:all)
        locations.first
    end
end