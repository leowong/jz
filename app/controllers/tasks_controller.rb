class TasksController < ApplicationController
  before_filter :login_required
  
  def index
    @tasks = Task.scoped
    @task = Task.new
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(params[:task])
    if @task.save
      redirect_to tasks_path, :notice => "Successfully created task."
    else
      render :action => 'new'
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.toggle_completed and return if params[:task].blank?

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to tasks_path, :notice  => "Successfully updated task." }
        format.js
      else
        format.html { render :action => 'edit' }
        format.js
      end
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_url, :notice => "Successfully destroyed task."
  end
end
