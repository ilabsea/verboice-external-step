module Steps
  class DetectMobileOperator
    def self.response options={}
      tel = Tel.new(options[:address])
      "{\"result\": \"#{tel.operator_code}\"}"
    end

  end
end