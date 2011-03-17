class ApplicationController < ActionController::Base
  include ControllerAuthentication
  before_filter { |c| User.current_user = c.current_user }
  protect_from_forgery
end
