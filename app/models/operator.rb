class Operator < ActiveRecord::Base
	validates :code, :name, presence: true
	serialize :prefixes, Array

	SEPERATOR_DELIMETER = ","
	SEPERATOR_DELIMETER_DISPLAY = ", "

end
