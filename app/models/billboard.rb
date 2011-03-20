class Billboard < ActiveRecord::Base
  attr_accessible :title, :content, :user_id
end
