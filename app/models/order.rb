class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  validates :quantity,
          presence: true,
          numericality: { only_integer: true, greater_than: 0 }

validates :price,
          presence: true,
          numericality: { greater_than: 0 }


  accepts_nested_attributes_for :order_items
  after_create_commit do
    OrderConfirmationJob.perform_later(self.id)
  end
end
