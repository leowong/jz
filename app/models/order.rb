class Order < ActiveRecord::Base
  belongs_to :contact
  has_many :line_items, :dependent => :destroy

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
end
