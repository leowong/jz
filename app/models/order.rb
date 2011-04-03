# encoding: utf-8
class Order < ActiveRecord::Base
  attr_accessible :contact, :contact_id, :shipping_method, :line_items_attributes, :addresses_attributes

  belongs_to :contact
  has_many :line_items, :dependent => :destroy
  has_many :notes, :as => :annotatable
  has_many :activities, :as => :topic
  has_many :addresses, :as => :addressable
  
  accepts_nested_attributes_for :line_items,
                                :reject_if => proc { |attrs| attrs.any? { |k, v| v.blank? } },
                                :allow_destroy => true

  accepts_nested_attributes_for :addresses, :reject_if => :all_blank

  scope :completed, where("state = 'completed'")

  STATES = {
    :pending => "待处理",
    :processing => "处理中",
    :completed => "已完成"
  }

  SHIPPING_METHOD = [
    ["送货上门", 1],
    ["物流配送", 2],
    ["客户自提", 3]
  ]

  def to_param
    number.to_s.parameterize.upcase
  end

  def update_number
    if number.blank?
      n = Digest::MD5.hexdigest(id.to_s + created_at.to_i.to_s)[0...7].upcase
      while self.class.find_by_number(n) do
        n = Digest::MD5.hexdigest(n)[0...7].upcase
      end
      update_attribute(:number, n)
    end
    number
  end

  def combine_items
    sums = line_items.group(:product_id).sum(:quantity)

    sums.each do |product_id, quantity|
      if quantity > 1
        line_items.where(:product_id => product_id).delete_all
        line_items.create(:product_id => product_id, :quantity => quantity)
      end
    end
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  def total_products
    line_items.to_a.sum { |item| item.quantity }
  end

  state_machine :state, :initial => :pending do
    after_transition :on => :process do |order, transition|
      Activity.add(User.current_user, order.contact, order, "process")
    end

    after_transition :on => :complete do |order, transition|
      order.update_attribute(:completed_at, Time.zone.now)
      Activity.add(User.current_user, order.contact, order, "complete")
    end

    event :process do
      transition :from => :pending, :to => :processing
    end
    
    event :complete do
      transition :from => :processing, :to => :completed
    end
  end

  def state_name
    Order::STATES[self.state.to_sym]
  end

  def shipping_method_name
    shipping_method ?
      Order::SHIPPING_METHOD.select { |a| a[1] == shipping_method }[0][0] : nil
  end

  def clone_address_from(contact)
    unless contact.addresses.empty?
      addresses.build(contact.addresses[0].attributes.except("id", "updated_at", "created_at", "addressable_id", "addressable_tye"))
    else
      addresses.build()
    end
  end
end
