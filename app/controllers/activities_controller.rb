class ActivitiesController < ApplicationController
  before_filter :login_required

  def index
    @activities = Activity.all
  end

  def show
    @activity = Activity.find(params[:id])
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(params[:activity])
    if @activity.save
      redirect_to @activity, :notice => t('notice.create_successful')
    else
      render :action => 'new'
    end
  end

  def edit
    @activity = Activity.find(params[:id])
  end

  def update
    @activity = Activity.find(params[:id])
    if @activity.update_attributes(params[:activity])
      redirect_to @activity, :notice  => "Successfully updated activity."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
    redirect_to activities_url, :notice => t('notice.destroy_successful')
  end
end
