class AddMobileAndPhoneToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :mobile, :string
    add_column :users, :phone, :string
  end

  def self.down
    remove_column :users, :phone
    remove_column :users, :mobile
  end
end
