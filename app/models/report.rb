class Report < ActiveRecord::Base
  attr_accessible :title, :content, :user_id, :apply_to
end
