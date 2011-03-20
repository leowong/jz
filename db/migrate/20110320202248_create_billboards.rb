class CreateBillboards < ActiveRecord::Migration
  def self.up
    create_table :billboards do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :billboards
  end
end
