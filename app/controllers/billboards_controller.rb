class BillboardsController < ApplicationController
  def index
    @billboards = Billboard.all
  end

  def show
    @billboard = Billboard.find(params[:id])
  end

  def new
    @billboard = Billboard.new
  end

  def create
    @billboard = Billboard.new(params[:billboard])
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
