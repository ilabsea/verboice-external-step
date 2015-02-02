class AccountsController < ApplicationController
  def index
    render json: Service::Account.all
  end

end