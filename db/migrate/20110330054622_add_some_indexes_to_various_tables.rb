class AddSomeIndexesToVariousTables < ActiveRecord::Migration
  def self.up
    add_index :activities, :user_id
    add_index :activities, :subject_id
    add_index :activities, :subject_type
    add_index :activities, :topic_id
    add_index :activities, :topic_type
    add_index :activities, :action

    add_index :addresses, :province_id
    add_index :addresses, :city_id
    add_index :addresses, :contact_id

    add_index :annotations, :annotatable_id
    add_index :annotations, [:annotatable_type, :type]

    add_index :assets, :attachable_id
    add_index :assets, [:attachable_type, :type]

    add_index :cities, :name
    add_index :cities, :province_id

    add_index :contacts, :name
    add_index :contacts, :company
    add_index :contacts, :position
    add_index :contacts, :mobile
    add_index :contacts, :phone

    add_index :line_items, :order_id

    add_index :orders, :contact_id
    add_index :orders, :state

    add_index :provinces, :name

    add_index :reports, :user_id
    add_index :reports, :apply_to

    add_index :tasks, :user_id
    add_index :tasks, :assigned_to
    add_index :tasks, :completed_at
    add_index :tasks, :subject_id
    add_index :tasks, :subject_type
    add_index :tasks, :due_at

    add_index :users, :username
  end

  def self.down
    remove_index :users, :username
    
    remove_index :tasks, :due_at
    remove_index :tasks, :subject_type
    remove_index :tasks, :subject_id
    remove_index :tasks, :completed_at
    remove_index :tasks, :assigned_to
    remove_index :tasks, :user_id
    
    remove_index :reports, :apply_to
    remove_index :reports, :user_id
    
    remove_index :provinces, :name
    
    remove_index :orders, :state
    remove_index :orders, :contact_id
    
    remove_index :line_items, :order_id
    
    remove_index :contacts, :phone
    remove_index :contacts, :mobile
    remove_index :contacts, :position
    remove_index :contacts, :company
    remove_index :contacts, :name
    
    remove_index :cities, :province_id
    remove_index :cities, :name
    
    remove_index :assets, [:attachable_type, :type]
    remove_index :assets, :attachable_id
    
    remove_index :annotations, [:annotatable_type, :type]
    remove_index :annotations, :annotatable_id
    
    remove_index :addresses, :contact_id
    remove_index :addresses, :city_id
    remove_index :addresses, :province_id
    
    remove_index :activities, :action
    remove_index :activities, :topic_type
    remove_index :activities, :topic_id
    remove_index :activities, :subject_type
    remove_index :activities, :subject_id
    remove_index :activities, :user_id
  end
end
