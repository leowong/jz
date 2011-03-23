class ProvincesController < ApplicationController
  def index
    @provinces = Province.all
  end

  def show
    @province = Province.find(params[:id])
  end

  def new
    @province = Province.new
  end

  def create
    @province = Province.new(params[:province])
    if @province.save
      redirect_to @province, :notice => t('notice.create_successful')
    else
      render :action => 'new'
    end
  end

  def edit
    @province = Province.find(params[:id])
  end

  def update
    @province = Province.find(params[:id])
    if @province.update_attributes(params[:province])
      redirect_to @province, :notice  => "Successfully updated province."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @province = Province.find(params[:id])
    @province.destroy
    redirect_to provinces_url, :notice => t('notice.destroy_successful')
  end
end
