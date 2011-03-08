class Contact < ActiveRecord::Base
  has_many :orders
  has_many :addresses

  accepts_nested_attributes_for :addresses,
                                :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } },
                                :allow_destroy => true
end
