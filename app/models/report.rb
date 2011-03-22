class Report < ActiveRecord::Base
  attr_accessible :title, :content, :user_id, :apply_to

  belongs_to :user
  belongs_to :applyee, :class_name => "User", :foreign_key => :apply_to
  has_many :notes, :as => :annotatable
  has_many :activities, :as => :topic

  validates_presence_of :title, :content, :apply_to
end
