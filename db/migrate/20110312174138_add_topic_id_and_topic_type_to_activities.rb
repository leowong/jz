class AddTopicIdAndTopicTypeToActivities < ActiveRecord::Migration
  def self.up
    add_column :activities, :topic_id, :integer
    add_column :activities, :topic_type, :string
  end

  def self.down
    remove_column :activities, :topic_type
    remove_column :activities, :topic_id
  end
end
