class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

    validates :email, :password, presence: true
    validates :password, length: { in: 8..15 }
    validates :password, format: {
      with: /\A(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[^A-Za-z0-9]).+\z/,
      message: "must have at least one letter, one number, and one special character"
    }

    has_one :cart
    has_many :orders



end
