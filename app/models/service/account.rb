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

  def steps
    steps = []

    step_permissions = StepPermission.where(user_email: email).includes(:step)
    step_permissions.each do |step_permission|
      steps.push step_permission.step if step_permission.step
    end

    steps
  end

end
