class Order < ActiveRecord::Base
  belongs_to :contact
  has_many :line_items, :dependent => :destroy
end
