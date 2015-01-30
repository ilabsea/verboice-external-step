module Steps
  class IloRating
    def self.response options={}
      tel = Tel.new(options[:address])
      now = ::Date.today
      code = ::IloRating.get_code(tel: tel, date: now)
            
      "{\"result\": \"#{code}\"}"
    end
  end
end