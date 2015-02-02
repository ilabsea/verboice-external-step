class Service::Account < ActiveApi
  attribute :id, Integer
  attribute :email, String
  attribute :role, Integer
  attribute :auth_token, String

  VERBOICE_ROLE_ADMIN = 1
  VERBOICE_ROLE_USER = 2

  def admin?
    role == VERBOICE_ROLE_ADMIN
  end

end
