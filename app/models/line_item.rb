class LineItem < ActiveRecord::Base
  attr_accessible :order, :product_id, :quantity, :price
  
  belongs_to :order
  belongs_to :product

  default_scope order("product_id, quantity, price")

  validates :order_id, :product_id, :quantity, :presence => true
  validates_associated :product
  validates :quantity, :numericality => { :only_integer => true, :greater_than => 0 }

  def total_price
    price * quantity
  end
end
