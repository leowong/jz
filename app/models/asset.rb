class Asset < ActiveRecord::Base
  attr_accessible :attachable_id, :attachable_type, :attachment_file_name, :attachment_content_type, :attachment_file_size, :attachment_updated_at, :type
end
