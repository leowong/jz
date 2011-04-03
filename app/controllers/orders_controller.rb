class OrdersController < ApplicationController
  before_filter :login_required
  helper_method :sort_column, :sort_direction
  
  def index
    @orders = Order.order(sort_column + " " + sort_direction)
  end

  def show
    @order = Order.find_by_number(params[:id])
    @note = @order.notes.build()
    @line_item = LineItem.new(:order => @order)
  end

  def new
    @order = Order.new
  end

  def edit
    @order = Order.find_by_number(params[:id])
    @order.addresses.build() if @order.addresses.blank?
    @cities = Hash.new { |h, k| h[k] = [] }
    City.all.each do |city|
      @cities[city.province_id.to_s].push([city.id, city.name])
    end
  end

  def create
    @order = Order.new(params[:order])
    unless @order.line_items.empty?
      @order.save
      @order.update_number
      @order.combine_items
      Activity.add(current_user, @order.contact, @order)
    end
    redirect_to @order.contact
  end

  def update
    @order = Order.find_by_number(params[:id])

    if params[:e] # TODO: validations
      @order.send(params[:e])
      redirect_to @order
    elsif @order.update_attributes(params[:order])
      @order.combine_items
      redirect_to @order, :notice => t('notice.update_successful')
    else
      format.html { render :action => "edit" }
    end
  end

  def destroy
    @order = Order.find_by_number(params[:id])
    @order.destroy

    redirect_to orders_url
  end

  private

  def sort_column
    Order.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
