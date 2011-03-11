class Contact < ActiveRecord::Base
  has_many :orders
  has_many :addresses
  has_many :provinces, :through => :addresses
  has_many :cities, :through => :addresses
  has_many :notes, :as => :annotatable

  accepts_nested_attributes_for :addresses,
                                :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } },
                                :allow_destroy => true

  SEARCH_COLUMNS = %w[contacts.name provinces.name cities.name]

  private

  def self.searching(query)
    includes([:provinces, :cities]).where(search_conditions(query))
  end

  def self.search_conditions(query)
    like = ActiveRecord::Base.connection.adapter_name == 'PostgreSQL' ? 'ILIKE' : 'LIKE'
    query.split(/\s+/).map do |word|
      '(' + SEARCH_COLUMNS.map { |col| "#{col} #{like} #{sanitize('%' + word.to_s + '%')}" }.join(' OR ') + ')'
    end.join(' AND ')
  end
end
