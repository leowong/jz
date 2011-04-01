class AddMoreColumnsToAddresses < ActiveRecord::Migration
  def self.up
    add_column :addresses, :firstname, :string
    add_column :addresses, :lastname, :string
    add_column :addresses, :address1, :string
    add_column :addresses, :address2, :string
    add_column :addresses, :zipcode, :string
  end

  def self.down
    remove_column :addresses, :zipcode
    remove_column :addresses, :address2
    remove_column :addresses, :address1
    remove_column :addresses, :lastname
    remove_column :addresses, :firstname
  end
end
