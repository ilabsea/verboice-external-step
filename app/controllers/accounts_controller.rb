class AccountsController < ApplicationController
  def index
    accounts = Service::Account.all
    accounts = accounts.select { |acc| acc.email.match("^#{params[:q]}") } if params[:q].present?

    render json: accounts
  end
end
