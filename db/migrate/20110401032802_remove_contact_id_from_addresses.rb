class RemoveContactIdFromAddresses < ActiveRecord::Migration
  def self.up
    remove_index :addresses, :contact_id
    remove_column :addresses, :contact_id
  end

  def self.down
    add_column :addresses, :contact_id, :integer
    add_index :addresses, :contact_id

    Address.reset_column_information
    Address.all.each do |a|
      a.update_attribute(:contact_id, a.addressable_id)
    end
  end
end
