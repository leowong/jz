class Address < ActiveRecord::Base
  attr_accessible :province_id, :city_id

  belongs_to :province
  belongs_to :city

  validates_associated :province, :city
end
