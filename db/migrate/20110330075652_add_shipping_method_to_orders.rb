class AddShippingMethodToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :shipping_method, :integer
  end

  def self.down
    remove_column :orders, :shipping_method
  end
end
