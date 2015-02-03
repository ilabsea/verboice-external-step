class AdminController < ApplicationController
  before_action :verify_admin

  def verify_admin
    head :unauthorized unless current_access.admin?
  end

end
