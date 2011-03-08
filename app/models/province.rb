class Province < ActiveRecord::Base
  attr_accessible :name, :abbreviation

  has_many :cities
end
