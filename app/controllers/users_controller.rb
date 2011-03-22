class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create]

  def index
    if params[:q].blank?
      @users = User.all
    else
      query = ('%' + params[:q] + '%')
      @users = User.where("username LIKE '#{query}'")
    end
  end

  def new
    @user = User.new
  end

  def show
    @user = params[:id] ? User.find(params[:id]) : current_user
    @activities = Activity.order('created_at DESC')
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Thank you for signing up! You are now logged in."
    else
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Your profile has been updated."
    else
      render :action => 'edit'
    end
  end
end
