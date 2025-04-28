class OrderSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :total_price, :created_date

  has_many :order_items

  def created_date
    object.created_at.strftime("%d-%m-%Y")
  end
end
