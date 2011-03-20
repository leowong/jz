class BillboardsController < ApplicationController
  before_filter :login_required

  def index
    @billboards = Billboard.order("created_at DESC")
  end

  def show
    @billboard = Billboard.find(params[:id])
  end

  def new
    @billboard = Billboard.new
  end

  def create
    @billboard = Billboard.new(params[:billboard].merge(:user_id => current_user.id))
    if @billboard.save
      redirect_to @billboard, :notice => "Successfully created billboard."
    else
      render :action => 'new'
    end
  end

  def edit
    @billboard = Billboard.find(params[:id])
  end

  def update
    @billboard = Billboard.find(params[:id])
    params[:billboard].delete(:user_id) if params[:billboard] and params[:billboard][:user_id]
    if @billboard.update_attributes(params[:billboard])
      redirect_to @billboard, :notice  => "Successfully updated billboard."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @billboard = Billboard.find(params[:id])
    @billboard.destroy
    redirect_to billboards_url, :notice => "Successfully destroyed billboard."
  end
end
