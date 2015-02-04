module Steps
  class PeriodRating
    def self.response options={}
      tel = Tel.new(options[:address])
      now = ::Date.today
      
      code = ::PeriodRating.get_code_of date: now, tel: tel

      "{\"result\": \"#{code}\"}"
    end
  end
end