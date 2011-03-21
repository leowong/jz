class Billboard < ActiveRecord::Base
  attr_accessible :title, :content, :user_id, :documents_attributes

  belongs_to :user
  has_many :documents, :as => :attachable, :dependent => :destroy
  has_many :notes, :as => :annotatable
  has_many :activities, :as => :topic

  accepts_nested_attributes_for :documents, :reject_if => :all_blank, :allow_destroy => true

  validates_presence_of :title, :content
end
