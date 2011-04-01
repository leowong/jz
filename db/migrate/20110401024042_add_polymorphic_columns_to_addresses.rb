class AddPolymorphicColumnsToAddresses < ActiveRecord::Migration
  def self.up
    add_column :addresses, :addressable_id, :integer
    add_column :addresses, :addressable_type, :string

    add_index :addresses, :addressable_id
    add_index :addresses, :addressable_type

    Address.reset_column_information
    Address.all.each do |a|
      a.update_attributes(:addressable_id => a.contact_id, :addressable_type => 'Contact')
    end
  end

  def self.down
    remove_index :addresses, :addressable_type
    remove_index :addresses, :addressable_id
    
    remove_column :addresses, :addressable_type
    remove_column :addresses, :addressable_id
  end
end
