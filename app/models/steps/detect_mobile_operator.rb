module Steps
  class DetectMobileOperator < Step
    def initialize
      super
      @name = 'detect_mobile_operator'
      @display_name = 'Detetct Mobile Operator'
    end

    def config_settings
      []
    end

    def config_response
       StepVariable.new(name: 'result', display_name: 'Result', type: 'string')
    end

    def self.response options={}
      tel = Tel.new(options[:address])
      "{\"result\": \"#{tel.operator_code}\"}"
    end

  end
end