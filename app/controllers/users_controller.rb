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
    render :layout => "session"
  end

  def show
    @user = params[:id] ? User.find(params[:id]) : current_user
    @activities = Activity.order('created_at DESC') unless params[:id]
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, :notice => t('notice.signup_successful')
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
      redirect_to root_url, :notice => t('notice.update_successful')
    else
      render :action => 'edit'
    end
  end
end
