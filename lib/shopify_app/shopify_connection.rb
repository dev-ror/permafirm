module ShopifyApp::ShopifyConnection
    def self.initialize
        byebug
        shopify_session = ShopifyAPI::Session.new(
            domain: "permadev.myshopify.com",
            api_version: '2020-04',
            token: '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')
    end
    def self.location
        locations = ShopifyAPI::Location.find(:all)
        locations.first
    end
end