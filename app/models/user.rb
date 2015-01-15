class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLE_ADMIN = 1
  ROLE_USER = 2

  def self.normal_users
    where(role: ROLE_USER)
  end

  def admin?
    role == ROLE_ADMIN
  end

  def role_name
    admin? ? 'Admin' : 'User'
  end

end
