class Note < Annotation
  def to_header
    case self.annotatable.class.to_s 
    when 'Contact' 
      self.annotatable.name 
    when 'Order'
      self.annotatable.contact.name + " (##{annotatable.number})"
    when 'Billboard'
      self.annotatable.title
    else
      "Note"
    end
  end
end
