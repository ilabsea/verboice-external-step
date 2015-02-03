module Steps
  class PeriodRating
    def self.response options={}
      tel = Tel.new(options[:address])
      now = ::Date.today
      
      code = get_code_of date: now, tel: tel

      "{\"result\": \"#{code}\"}"
    end

    def self.get_code_of(date:, tel:)
      rating = ::PeriodRating.get(date: date)
      rating.nil? ? ::PeriodRating::NON_EXISTING : rating.get_code_of(tel: tel)
    end

  end
end