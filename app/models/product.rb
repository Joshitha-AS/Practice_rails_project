class Product < ApplicationRecord
    validates :name,
            presence: true,
            length: { in: 2..100 }

  validates :price,
            presence: true,
            numericality: { greater_than: 0 }
    
    has_many :cart_items
    has_many :carts, through: :cart_items
end
