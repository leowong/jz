class Contact < ActiveRecord::Base
  has_many :orders
end
