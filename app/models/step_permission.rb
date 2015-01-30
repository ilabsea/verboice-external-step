class StepPermission < ActiveRecord::Base
  belongs_to :step
  validates :user_id, presence:true, uniqueness: true
  validates :user_email,presence: true, uniqueness: true
end
