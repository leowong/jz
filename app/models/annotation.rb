class Annotation < ActiveRecord::Base
  attr_accessible :content, :annotatable_id, :annotatable_type, :type

  belongs_to :annotatable, :polymorphic => true
end
