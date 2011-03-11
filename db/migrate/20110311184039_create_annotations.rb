class CreateAnnotations < ActiveRecord::Migration
  def self.up
    create_table :annotations do |t|
      t.text :content
      t.integer :annotatable_id
      t.string :annotatable_type
      t.string :type
      t.timestamps
    end
  end

  def self.down
    drop_table :annotations
  end
end
