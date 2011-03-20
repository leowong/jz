class Task < ActiveRecord::Base
  attr_accessible :user_id, :assigned_to, :completed_by, :name, :subject_id, :subject_type, :due_at, :completed_at, :deleted_at

  before_save :setup_user

  scope :upcoming, where("completed_at IS NULL")
  scope :completed, where("completed_at IS NOT NULL")

  validates_presence_of :name, :due_at, :assigned_to

  def toggle_completed
    if completed?
      update_attribute(:completed_at, nil)
    else
      update_attribute(:completed_at, Time.zone.now)
    end
  end

  def completed?
    completed_at?
  end

  private

  def setup_user
    self.user_id = User.current_user
  end
end
