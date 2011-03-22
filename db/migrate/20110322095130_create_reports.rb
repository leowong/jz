class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.integer :apply_to
      t.timestamps
    end
  end

  def self.down
    drop_table :reports
  end
end
