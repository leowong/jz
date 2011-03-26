class DashboardController < ApplicationController
  before_filter :login_required

  def index
    @user = current_user
    @activities = Activity.order('created_at DESC')
  end
end
