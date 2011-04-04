class ApplicationController < ActionController::Base
  include ControllerAuthentication
  before_filter { |c| User.current_user = c.current_user }
  protect_from_forgery

  private

  def cities
    @cities = Hash.new { |h, k| h[k] = [] }
    City.all.each do |city|
      @cities[city.province_id.to_s].push([city.id, city.name])
    end
  end

  def prices
    @prices = {}
    Product.all.each do |product|
      @prices[product.id.to_s] = sprintf("%.2f", product.price)
    end
  end
end
