module Shopify::ShopifyConnection
    def self.connect_to_shop(domain, token)
        shopify_session = ShopifyAPI::Session.new(domain: domain,api_version: '2020-04',token: token)
        
        ShopifyAPI::Base.activate_session(shopify_session)
        
    end
    def self.location
        locations = ShopifyAPI::Location.find(:all)
        locations.first
    end
end