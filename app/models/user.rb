class User < ApplicationRecord
    has_secure_password

    validates :email,
              presence: true,
              uniqueness: true,
              format: { with: URI::MailTo::EMAIL_REGEXP }

    validates :name,
              presence: true,
              length: { in: 2..50 }

    validates :password,
              length: { in: 6..10 },
              if: -> { new_record? || !password.nil? }

    has_one :cart
    has_many :orders
end
