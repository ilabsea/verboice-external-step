class AccountsController < ApplicationController
	before_action :verify_admin

  def index
    @users = User.normal_users
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new protected_params
  	if @user.save
  		redirect_to accounts_path, notice: "User #{@user.email} has been created"
  	else
  		flash[:alert] = "Can't save, Something went wrong"
  		render :new
  	end
  end

  def destroy
		user = User.find(params[:id])
		if user.destroy
			redirect_to accounts_path, notice: "User #{user.email} has been deleted"
		end
  end

  private
  def protected_params
  	params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end

  def verify_admin
  	unless current_user.admin?
  		render text: 'Page not found', status: :not_found
  	end
  end

end