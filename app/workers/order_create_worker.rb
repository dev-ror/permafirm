require 'rubygems'
class OrderCreateWorker

  include Sidekiq::Worker
  sidekiq_options :retry => 0


  def perform(data)
    @order = Order.new_order_from_json(data)
    @order.save
  end

end