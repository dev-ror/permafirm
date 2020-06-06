Rails.application.routes.draw do
  resources :order_line_items
  resources :orders
  resources :product_variants
  resources :products
  get 'import_product', to: 'products#import_product'
  devise_for :users
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/app'
  get '/app' => 'settings#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
