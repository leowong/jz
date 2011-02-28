class Order < ActiveRecord::Base
  belongs_to :contact
  has_many :line_items, :dependent => :destroy

  accepts_nested_attributes_for :line_items, :reject_if => :all_blank, :allow_destroy => true
end
