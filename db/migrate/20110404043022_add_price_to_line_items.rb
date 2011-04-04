class AddPriceToLineItems < ActiveRecord::Migration
  def self.up
    add_column :line_items, :price, :decimal

    LineItem.reset_column_information
    LineItem.all.each do |line_item|
      if product = Product.find_by_id(line_item.product_id)
        line_item.update_attribute(:price, product.price)
      end
    end
  end

  def self.down
    remove_column :line_items, :price
  end
end
