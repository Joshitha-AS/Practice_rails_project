class OrderMailer < ApplicationMailer
  def confirmation_email(order)
    @order = order
    @user = order.user
    mail(to: @user.email, subject: "Your order has been placed!")
  end
end
