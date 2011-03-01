class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find_by_number(params[:id])
    @line_item = LineItem.new(:order => @order)
  end

  def new
    @order = Order.new
  end

  def edit
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(params[:order])
    @order.save
    @order.update_number
    redirect_to @order.contact
  end

  def update
    @order = Order.find(params[:id])

    if @order.update_attributes(params[:order])
      redirect_to @order, :notice => 'Order was successfully updated.'
    else
      format.html { render :action => "edit" }
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    redirect_to orders_url
  end
end
