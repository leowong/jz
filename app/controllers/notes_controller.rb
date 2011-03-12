class NotesController < AnnotationsController
  def create
    @note = Note.new(params[:note])
    @note.save
    redirect_to annotatable
  end
end
