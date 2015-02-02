class ApplicationController < ActionController::Base
  protect_from_forgery

  include Authenticable

  helper_method :current_access, :user_signed_in?

end
