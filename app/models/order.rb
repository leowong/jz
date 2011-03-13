class Order < ActiveRecord::Base
  belongs_to :contact
  has_many :line_items, :dependent => :destroy
  has_many :notes, :as => :annotatable
  has_many :activities, :as => :topic

  accepts_nested_attributes_for :line_items,
                                :reject_if => proc { |attrs| attrs.any? { |k, v| v.blank? } },
                                :allow_destroy => true

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

  state_machine :state, :initial => :pending do
    event :process do
      transition :from => :pending, :to => :processing
    end
    
    event :complete do
      transition :from => :processing, :to => :completed
    end
  end
end
