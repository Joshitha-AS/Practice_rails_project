class OrderConfirmationWorker
  include Sidekiq::Worker

  def perform(order_id)
    order = Order.find(order_id)
    puts "Sending confirmation for Order ##{order.id}"
    return if order.nil? || order.user.nil?
    OrderMailer.confirmation_email(order).deliver_now
  end
end