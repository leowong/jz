class TasksController < ApplicationController
  def index
    @tasks = Task.scoped
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
      redirect_to @task, :notice => "Successfully created task."
    else
      render :action => 'new'
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        @task.toggle_completed if params[:task].blank?
        format.html { redirect_to @task, :notice  => "Successfully updated task." }
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
