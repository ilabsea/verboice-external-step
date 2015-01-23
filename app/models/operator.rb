class Operator < ActiveRecord::Base
	validates :code, :name, presence: true
	serialize :prefixes, Array

	SEPERATOR_DELIMETER = ","
	SEPERATOR_DELIMETER_DISPLAY = ", "

	OTHER = 'other'

	def self.other
		find_by_name(OTHER)
	end

	def self.get area_code:
    operator = nil

    all.each do |op|
    	if op.exist? area_code
	      operator = op
	      break
	    end
    end

    operator
	end

	def exist? area_code
		found = false
		prefixes.each do |prefix|
    	if prefix.to_i == area_code.to_i
       	found = true
       	break
       end
    end
    found
	end

end
