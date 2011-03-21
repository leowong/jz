class Asset < ActiveRecord::Base
  attr_accessible :attachable_id, :attachable_type, :attachment, :type

  belongs_to :attachable, :polymorphic => true
end
