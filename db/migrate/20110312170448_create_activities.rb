class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.integer :user_id
      t.integer :subject_id
      t.string :subject_type
      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
