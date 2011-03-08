class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.integer :province_id
      t.integer :city_id
      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
