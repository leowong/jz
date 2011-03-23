class Activity < ActiveRecord::Base
  attr_accessible :user_id, :topic_id, :topic_type, :subject_id, :subject_type, :action

  belongs_to :user
  belongs_to :topic, :polymorphic => true
  belongs_to :subject, :polymorphic => true

  scope :aggregate_for, lambda { |topic|
    case topic.class.to_s
    when "Contact"
      order_ids = %(SELECT id FROM orders WHERE contact_id = :topic_id)
      where("(topic_id IN (#{order_ids}) AND topic_type = 'Order') OR (topic_id = :topic_id AND topic_type = :topic_type)", { :topic_id => topic.id, :topic_type => topic.class.to_s })
    when "Order"
      where("(subject_id = :topic_id AND subject_type = :topic_type) OR (topic_id = :topic_id AND topic_type = :topic_type)", { :topic_id => topic.id, :topic_type => topic.class.to_s })
    else
      topic.activities.scoped
    end
  }

  def self.add(user, topic, subject, action=nil)
    self.create(
      :user_id => user.id,
      :topic_id => topic.id, :topic_type => topic.class.to_s,
      :subject_id => subject.id, :subject_type => subject.class.to_s,
      :action => action
    )
  end
end
