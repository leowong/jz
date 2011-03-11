class AnnotationsController < ApplicationController
  def index
    @annotations = Annotation.all
  end

  def show
    @annotation = Annotation.find(params[:id])
  end

  def new
    @annotation = Annotation.new
  end

  def create
    @annotation = Annotation.new(params[:annotation])
    if @annotation.save
      redirect_to @annotation, :notice => "Successfully created annotation."
    else
      render :action => 'new'
    end
  end

  def edit
    @annotation = Annotation.find(params[:id])
  end

  def update
    @annotation = Annotation.find(params[:id])
    if @annotation.update_attributes(params[:annotation])
      redirect_to @annotation, :notice  => "Successfully updated annotation."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @annotation = Annotation.find(params[:id])
    @annotation.destroy
    redirect_to annotations_url, :notice => "Successfully destroyed annotation."
  end
end
