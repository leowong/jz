class ContactsController < ApplicationController
  before_filter :login_required
  before_filter :cities, :only => [:show, :new, :edit]
  before_filter :prices, :only => :show

  def index
    if params[:q].blank?
      @contacts = Contact.order('updated_at DESC')
    else
      @contacts = Contact.searching(params[:q]).order('contacts.updated_at DESC')
    end
  end

  def show
    @contact = Contact.find(params[:id])
    @note = @contact.notes.build()
    @order = Order.new(:contact => @contact)
    @completed_orders = @contact.orders.completed
    @order.clone_address_from(@contact)
  end

  def new
    @contact = Contact.new
    @contact.addresses.build()
  end

  def edit
    @contact = Contact.find(params[:id])
    @contact.addresses.build() if @contact.addresses.blank?
  end

  def create
    @contact = Contact.new(params[:contact])

    if @contact.save
      redirect_to @contact, :notice => t('notice.create_successful')
    else
      render :action => "new"
    end
  end

  def update
    @contact = Contact.find(params[:id])

    if @contact.update_attributes(params[:contact])
      redirect_to @contact, :notice => t('notice.update_successful')
    else
      render :action => "edit"
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    redirect_to contacts_url
  end
end
