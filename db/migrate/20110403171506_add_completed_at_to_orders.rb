class AddCompletedAtToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :completed_at, :datetime

    Order.reset_column_information
    Order.all.each do |order|
      order.update_attribute(:completed_at, order.updated_at) if order.completed?
    end
  end

  def self.down
    remove_column :orders, :completed_at
  end
end
