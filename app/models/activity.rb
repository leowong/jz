class Activity < ActiveRecord::Base
  attr_accessible :user_id, :subject_id, :subject_type
end
