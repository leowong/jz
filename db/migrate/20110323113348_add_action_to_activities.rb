class AddActionToActivities < ActiveRecord::Migration
  def self.up
    add_column :activities, :action, :string
  end

  def self.down
    remove_column :activities, :action
  end
end
