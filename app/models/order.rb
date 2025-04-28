class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy


  accepts_nested_attributes_for :order_items
  after_create_commit do
    OrderConfirmationJob.perform_later(self.id)
  end
end
