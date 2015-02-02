class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    if user_signed_in?
      redirect_to after_sign_in_path, notice: 'You already signed in'
    else
      @login_form = LoginForm.new
      render layout: "layouts/sign_in"
    end
  end

  def create
    @login_form = LoginForm.new session_params

    if(@login_form.valid?)
      begin
        authentication = Service::Authentication.new(session_params[:email], session_params[:password])
        account = authentication.login!
        sign_in_and_redirect_for(account)
      rescue Service::ApiException => e
        flash.now[:alert]  = "Incorrect username or password"
        render_new
      end
    end
  end

  def destroy
    sign_out_and_redirect_for(current_access)
  end

  def session_params
    params.require(:login_form).permit(:email, :password)
  end

  def render_new
    render :new, layout: "layouts/sign_in"
  end

end
