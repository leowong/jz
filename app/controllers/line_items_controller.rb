class LineItemsController < ApplicationController
  def index
    @line_items = LineItem.all
  end

  def show
    @line_item = LineItem.find(params[:id])
  end

  def new
    @line_item = LineItem.new
  end

  def edit
    @line_item = LineItem.find(params[:id])
  end

  def create
    @line_item = LineItem.new(params[:line_item])

    if @line_item.save
        redirect_to @line_item, :notice => t('notice.create_successful')
    else
        render :action => "new"
    end
  end

  def update
    @line_item = LineItem.find(params[:id])

    if @line_item.update_attributes(params[:line_item])
        redirect_to @line_item, :notice => t('notice.update_successful')
    else
        render :action => "edit"
    end
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy

    redirect_to line_items_url
  end
end
