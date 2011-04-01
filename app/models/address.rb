class Address < ActiveRecord::Base
  attr_accessible :province_id, :city_id, :addressable_id, :addressable_type, :firstname, :address1, :zipcode

  belongs_to :province
  belongs_to :city

  validates_associated :province, :city
end
