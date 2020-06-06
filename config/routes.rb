Rails.application.routes.draw do
  resources :order_line_items
  resources :orders
  resources :product_variants
  resources :products
  devise_for :users
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
