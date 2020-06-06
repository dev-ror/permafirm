# frozen_string_literal: true

class ShopifyController < AuthenticatedController
# class HomeController < ApplicationController
  def index
    @products = ShopifyAPI::Product.find(:all, params: { limit: 10 })
    @webhooks = ShopifyAPI::Webhook.find(:all)
  end
end
