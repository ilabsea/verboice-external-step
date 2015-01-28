class Operator < ActiveRecord::Base
	validates :code, :name, presence: true
	serialize :prefixes, Array

	SEPERATOR = ","
	SEPERATOR_DISPLAY = ", "

	OTHER = 'other'

	class << self
		def other
			find_by_name(OTHER)
		end

		def get area_code:
	    operator = nil

	    all.each do |op|
	    	if op.exist? area_code
		      operator = op
		      break
		    end
	    end

	    operator
		end

		def update_prefix_setting operators:
			operators.each do |name, value|
				operator = find_by_name(name)
				if value || (!value.present? && !operator.prefixes.empty?)
					prefixes = value.split(SEPERATOR)
					operator.update_attributes(prefixes: prefixes)
				end
			end
		end
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
