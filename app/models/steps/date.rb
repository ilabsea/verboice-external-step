module Steps
  class Date
    def self.response options={}
      date = DateUnit.new(unit: options[:unit].downcase, value: options[:value].to_i).days.days.ago.strftime("%d/%m/%Y")
      "{\"result\": \"#{date}\"}"
    end
  end
end
