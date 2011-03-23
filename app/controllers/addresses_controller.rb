class AddressesController < ApplicationController
  def index
    @addresses = Address.all
  end

  def show
    @address = Address.find(params[:id])
  end

  def new
    @address = Address.new
    @cities = Hash.new { |h, k| h[k] = [] }
    City.all.each do |city|
      @cities[city.province_id.to_s].push([city.id, city.name])
    end
  end

  def create
    @address = Address.new(params[:address])
    if @address.save
      redirect_to @address, :notice => t('notice.create_successful')
    else
      render :action => 'new'
    end
  end

  def edit
    @address = Address.find(params[:id])
    @cities = Hash.new { |h, k| h[k] = [] }
    City.all.each do |city|
      @cities[city.province_id.to_s].push([city.id, city.name])
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update_attributes(params[:address])
      redirect_to @address, :notice  => "Successfully updated address."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_url, :notice => t('notice.destroy_successful')
  end
end
