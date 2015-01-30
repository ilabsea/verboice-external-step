class IloRating < ActiveRecord::Base
	validates :code, presence: true
	serialize :numbers, Array

	validates :code, uniqueness: true
	validates :code, length: { maximum: 2 }

	attr_accessor :client_from_date, :client_to_date, :addresses

	validates :client_from_date, :"validator/date" => { date_format: Date::DEFAULT_FORMAT, field: :from_date }, if: Proc.new { |record| record.new_record? }
	validates :client_to_date, :"validator/date" => { date_format: Date::DEFAULT_FORMAT, field: :to_date }, if: Proc.new { |record| record.new_record? }

	validate :unique_date_range, on: :create

	SEPERATOR = ","
	SEPERATOR_DISPLAY = ", "

	NON_EXISTING = 0
	EXISTING = 99

	class << self
		def get_code date:, tel:
			code = NON_EXISTING

			all.each do |r|
				if r.has_date? date
					code = r.code

					if r.has_number? tel.without_prefix
						code = EXISTING
					end

					break
				end
			end

			code
		end

		def get date:, tel:
			rating = nil

			all.each do |r|
				rating = r if r.exist? date: date, tel: tel
				break
			end

			rating
		end
	end

	def unique_date_range
		if client_from_date.present? && client_to_date.present?
			self.from_date = Parser::DateParser.parse(client_from_date)
			self.to_date = Parser::DateParser.parse(client_to_date)
			IloRating.all.each do |rating|
				if rating.from_date.between?(from_date, to_date) || rating.to_date.between?(from_date, to_date)
					errors.add(:date, 'date range already exists')
				end
			end
		end
	end

	def exist? tel:, date:
		found = false

		if has_date?(date)
			if has_number?(tel.without_prefix)
				found = true
			end
		end

		found
	end

	def has_date? date
		date.between?(from_date, to_date)
	end

	def has_number? number
		numbers.include?(number)
	end

	def addresses
		@addresses
	end

	def addresses=(val)
		@addresses = val
	end

	def client_from_date
		@client_from_date
	end

	def client_from_date=(val)
		@client_from_date = val
	end

	def client_to_date
		@client_to_date
	end

	def client_to_date=(val)
		@client_to_date = val
	end

end
