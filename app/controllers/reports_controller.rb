class ReportsController < ApplicationController
  before_filter :login_required

  def index
    @orders = Order.completed
  end
end

