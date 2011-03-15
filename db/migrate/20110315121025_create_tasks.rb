class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.integer :user_id
      t.integer :assigned_to
      t.integer :completed_by
      t.string :name
      t.integer :subject_id
      t.string :subject_type
      t.datetime :due_at
      t.datetime :completed_at
      t.datetime :deleted_at
      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
