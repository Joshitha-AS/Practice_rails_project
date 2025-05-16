class CartItem < ApplicationRecord
  validates :quantity, presence: true,
  numericality: { greater_than: 0, only_integer: true }

  belongs_to :cart
  belongs_to :product
end
