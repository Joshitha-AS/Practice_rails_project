class Product < ApplicationRecord
    validates :name, :price, presence: true
    validates :price, numericality: true
    


    has_many :cart_items
    has_many :carts, through: :cart_items
end
