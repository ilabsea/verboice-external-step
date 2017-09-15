module Authenticable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
    after_action :track_previous_page
  end

  def sign_in account
    session[:account] = Marshal.dump(account)
  end

  def sign_in_and_redirect_for account
    sign_in account

    if account.admin?
      redirect_to root_url, notice: 'You have been signed in successfully'
    else
      redirect_to root_url, notice: 'You have been signed in successfully'
    end
  end

  def sign_out
    session[:account] = nil
  end

  def sign_out_and_redirect_for account = nil
    sign_out
    if account && account.admin?
      redirect_to root_url, notice: 'You have been signed out'
    else
      redirect_to root_url, notice: 'You have been signed out'
    end
  end

  def user_signed_in?
    session[:account].present?
  end

  def current_access
    @current_access ||= Marshal.load(session[:account]) if user_signed_in?
  end

  def authenticate_user!
    if(!user_signed_in?)
      redirect_to sign_in_path, notice: 'You must sign in first to access this page'
    else
      ActiveApi.init_auth(current_access)
    end
  end

  def track_previous_page
    return nil if request.xhr?

    path = request.fullpath
    if(path != sign_in_path && path != sign_out_path && !request.xhr? )
      store_previous_page path
    end
  end

  def store_previous_page path
    session[:previous_page] = path
  end

  def previous_page
    session[:previous_page]
  end

end
