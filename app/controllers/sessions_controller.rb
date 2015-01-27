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
      auth = Session.login(session_params[:email], session_params[:password])
      if(Session.success?)
          sign_in(auth)
          redirect_to root_path
      else
        flash.now[:alert]  = "Incorrect username or password"
        render_new
      end
    else
      flash.now[:alert]  = "Incorrect username or password"
      render_new
    end
  end

  def destroy
    sign_out
    redirect_to sign_in_path
  end

  def session_params
    params.require(:login_form).permit(:email, :password)
  end

  def render_new
    render :new, layout: "layouts/sign_in"
  end

end
