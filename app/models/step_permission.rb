class StepPermission < ActiveRecord::Base
  belongs_to :step
  validates :user_id, presence:true, uniqueness: { scope: :step }
  validates :user_email, presence: true, uniqueness: { scope: :step }
end
