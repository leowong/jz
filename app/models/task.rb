class Task < ActiveRecord::Base
  attr_accessible :user_id, :assigned_to, :completed_by, :name, :subject_id, :subject_type, :due_at, :completed_at, :deleted_at
end
