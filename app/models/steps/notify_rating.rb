module Steps
  class NotifyRating

    def self.response options={}
      tel = Tel.new(options[:address])
      now = ::Date.today
      rating = ::IloRating.get(date: now)

      is_registered = 0
      if rating
        rating.register! tel
        is_registered = rating.has_telephone?(tel) ? 1 : 0
      end
            
      "{\"result\": \"#{is_registered}\"}"
    end

  end
end