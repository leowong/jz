class ReportsController < ApplicationController
  def index
    @orders = Order.completed
  end
end

