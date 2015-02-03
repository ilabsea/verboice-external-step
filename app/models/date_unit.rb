class DateUnit

	def initialize(unit:, value:)
		@unit = unit
		@value = value
	end

	def days
		return @value if @unit.match(/^(day)s?$/)
		return @value * 7 if @unit.match(/^(week)s?$/)
		return @value * 30 if @unit.match(/^(month)s?$/)
		return @value * 365 if @unit.match(/^(year)s?$/)
	end

end
