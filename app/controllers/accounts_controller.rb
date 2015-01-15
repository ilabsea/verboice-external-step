class AccountsController < ApplicationController
  def index
    if current_user.admin?
      @users = User.normal_users
    else
      render text: 'You are unauthorized', status: :unauthorized
    end
  end
end