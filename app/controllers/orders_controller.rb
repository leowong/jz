class OrdersController < ApplicationController
  before_filter :login_required
  
  def index
    @orders = Order.order("created_at DESC")
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
end
