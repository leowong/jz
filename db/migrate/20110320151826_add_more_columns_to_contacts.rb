class AddMoreColumnsToContacts < ActiveRecord::Migration
  def self.up
    add_column :contacts, :type1, :integer
    add_column :contacts, :type2, :integer
    add_column :contacts, :type3, :integer
    add_column :contacts, :sex, :boolean
    add_column :contacts, :age_range, :integer
    add_column :contacts, :mobile, :string
    add_column :contacts, :phone, :string
    add_column :contacts, :fax, :string
    add_column :contacts, :email, :string
    add_column :contacts, :company, :string
    add_column :contacts, :position, :string
    add_column :contacts, :source_id, :integer
    add_column :contacts, :interest, :integer
    add_column :contacts, :background_info, :text
  end

  def self.down
    remove_column :contacts, :background_info
    remove_column :contacts, :interest
    remove_column :contacts, :source_id
    remove_column :contacts, :position
    remove_column :contacts, :company
    remove_column :contacts, :email
    remove_column :contacts, :fax
    remove_column :contacts, :phone
    remove_column :contacts, :mobile
    remove_column :contacts, :age_range
    remove_column :contacts, :sex
    remove_column :contacts, :type3
    remove_column :contacts, :type2
    remove_column :contacts, :type1
  end
end
