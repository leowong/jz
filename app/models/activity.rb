class Activity < ActiveRecord::Base
  attr_accessible :user_id, :topic_id, :topic_type, :subject_id, :subject_type

  belongs_to :topic, :polymorphic => true
  belongs_to :subject, :polymorphic => true

  def self.add(user, topic, subject)
    self.create(
      :user_id => user.id,
      :topic_id => topic.id, :topic_type => topic.class.to_s,
      :subject_id => subject.id, :subject_type => subject.class.to_s
    )
  end
end
