class StepVariable < ActiveRecord::Base
	validates :name, :display_name, :kind, :direction, presence: true
	validates :name, uniqueness: { scope: :step_id }

	belongs_to :step

	DIRECTION_INCOMING = 'incoming'
	DIRECTION_OUTGOING = 'outgoing'

	def self.incoming
		where(direction: DIRECTION_INCOMING)
	end

	def self.outgoing
		where(direction: DIRECTION_OUTGOING)
	end

end
