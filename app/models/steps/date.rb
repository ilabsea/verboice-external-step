module Steps
  class Date < Step
    def initialize
      super
      @name = 'date'
      @display_name = 'Date'
    end

    def config_settings
      [ 
        StepVariable.new(name: 'unit', display_name: 'Unit', type: 'date_type'),
        StepVariable.new(name: 'value', display_name: 'Value', type: 'numeric')
      ]
    end

    def config_response
       StepVariable.new(name: 'result', display_name: 'Result', type: 'string')
    end

    def self.response options={}
      date = DateUnit.new(unit: options[:unit].downcase, value: options[:value].to_i).days.days.ago.strftime("%d/%m/%Y")
      "{\"result\": \"#{date}\"}"
    end
  end
end