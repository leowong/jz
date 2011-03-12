class AnnotationsController < ApplicationController
  private

  def annotatable
    params[:note][:annotatable_type].classify.constantize.find(params[:note][:annotatable_id])
  end
end
