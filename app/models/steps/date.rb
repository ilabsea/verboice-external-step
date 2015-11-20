module Steps
  class Date
    def self.response options={}
      number_of_days = DateUnit.new(options[:unit].downcase, options[:value].to_i).days
      date = number_of_days.days.ago.strftime("%d/%m/%Y") if number_of_days
      "{\"result\": \"#{date}\"}"
    end
  end
end
