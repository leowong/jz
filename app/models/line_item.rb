class LineItem < ActiveRecord::Base
  attr_accessible :order, :product_id, :quantity
  
  belongs_to :order
  belongs_to :product

  validates :order_id, :product_id, :quantity, :presence => true
  validates_associated :product
  validates :quantity, :numericality => { :only_integer => true, :greater_than => 0 }

  def total_price
    product.price * quantity
  end
end
