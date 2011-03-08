class ContactsController < ApplicationController
  def index
    @contacts = Contact.all
  end

  def show
    @contact = Contact.find(params[:id])
    @order = Order.new(:contact => @contact)
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
      redirect_to @contact, :notice => 'Contact was successfully created.'
    else
      render :action => "new"
    end
  end

  def update
    @contact = Contact.find(params[:id])

    if @contact.update_attributes(params[:contact])
      redirect_to @contact, :notice => 'Contact was successfully updated.'
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
