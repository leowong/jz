class Billboard < ActiveRecord::Base
  attr_accessible :title, :content, :user_id

  belongs_to :user

  validates_presence_of :title, :content
end
