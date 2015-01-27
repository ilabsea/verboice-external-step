class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if user_signed_in?
      redirect_to steps_path
    else
    	redirect_to sign_in_path
    end
  end

end