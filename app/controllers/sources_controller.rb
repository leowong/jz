class SourcesController < ApplicationController
  before_filter :login_required
  
  def index
    @sources = Source.all
  end

  def show
    @source = Source.find(params[:id])
  end

  def new
    @source = Source.new
  end

  def create
    @source = Source.new(params[:source])
    if @source.save
      redirect_to @source, :notice => "Successfully created source."
    else
      render :action => 'new'
    end
  end

  def edit
    @source = Source.find(params[:id])
  end

  def update
    @source = Source.find(params[:id])
    if @source.update_attributes(params[:source])
      redirect_to @source, :notice  => "Successfully updated source."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @source = Source.find(params[:id])
    @source.destroy
    redirect_to sources_url, :notice => "Successfully destroyed source."
  end
end
