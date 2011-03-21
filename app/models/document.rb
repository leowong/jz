class Document < Asset
  has_attached_file :attachment,
                    :url => "/assets/documents/:id/:basename.:extension",
                    :path => ":rails_root/public/assets/documents/:id/:basename.:extension"
end
