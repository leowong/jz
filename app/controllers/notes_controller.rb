class NotesController < AnnotationsController
  before_filter :login_required

  def create
    @note = Note.new(params[:note])
    if @note.save
      Activity.add(current_user, annotatable, @note)
    end
    redirect_to annotatable
  end
end
