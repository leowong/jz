class AddContactIdToAddress < ActiveRecord::Migration
  def self.up
    add_column :addresses, :contact_id, :integer
  end

  def self.down
    remove_column :addresses, :contact_id
  end
end
