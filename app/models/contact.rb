# encoding: utf-8
class Contact < ActiveRecord::Base
  belongs_to :source
  has_many :orders
  has_many :addresses
  has_many :provinces, :through => :addresses
  has_many :cities, :through => :addresses
  has_many :notes, :as => :annotatable
  has_many :activities, :as => :topic

  accepts_nested_attributes_for :addresses,
                                :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } },
                                :allow_destroy => true

  validates_presence_of :name

  SEARCH_COLUMNS = %w[
    contacts.name
    provinces.name
    cities.name
    contacts.company
    contacts.position
    contacts.mobile
    contacts.phone
  ]

  TYPE1 = [
    ["个人用户", 1],
    ["单位客户", 2],
    ["终端商场", 3],
    ["终端药店", 4],
    ["终端酒店", 5],
    ["终端会所", 6]
  ]

  TYPE2 = [
    ["富", 1],
    ["贵", 2],
    ["星", 3]
  ]

  TYPE3 = [
    ["农、林、牧、渔业", 1],
    ["采掘业", 2],
    ["制造业", 3],
    ["电力、煤气、水的生产和供应业", 4],
    ["建筑业", 5],
    ["地质勘查、水利管理业", 6],
    ["交通运输、仓储管理及邮电通信业", 7],
    ["批发和零售贸易餐饮业", 8],
    ["金融、保险业", 9],
    ["房地产业", 10],
    ["社会服务业", 11],
    ["卫生体育和社会福利业", 12],
    ["教育、文化艺术和广播电影电视业", 13],
    ["科学研究和综合技术服务业", 14],
    ["国家机关、政党机关和社会团体", 15]
  ]

  SEX = [["男", false], ["女", true]]

  AGE_RANGE = [
    ["21 - 30", 1],
    ["31 - 40", 2],
    ["41 - 50", 3],
    ["51 - 60", 4],
    ["61 - 70", 5],
    ["70 ~", 6]
  ]

  INTEREST = [
    ["价格", 1],
    ["效果", 2],
    ["品质", 3],
    ["是否适合", 4]
  ]

  def type1_name
    Contact::TYPE1.select { |a| a[1] == self.type1 }[0][0]
  end

  def type2_name
    Contact::TYPE2.select { |a| a[1] == self.type2 }[0][0]
  end

  def type3_name
    Contact::TYPE3.select { |a| a[1] == self.type3 }[0][0]
  end
  
  def sex_name
    Contact::SEX.select { |a| a[1] == self.sex }[0][0]
  end

  def age_range_name
    Contact::AGE_RANGE.select { |a| a[1] == self.age_range }[0][0]
  end

  def interest_name
    Contact::INTEREST.select { |a| a[1] == self.interest }[0][0]
  end

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
