class Step
  include Virtus.model

  attribute :name, String
  attribute :display_name, String
  attribute :description, String
  attribute :manifest, String
  attribute :inputs, Array
  attribute :outputs, Array

  DETECT_MOBILE_OPERATOR = 'detect_mobile_operator'

	def self.from_hash hash = {}
    
    input_variables = hash['input']['variables']['variable'].kind_of?(Hash) ? [hash['input']['variables']['variable']] : hash['input']['variables']['variable']
    
    inputs = []
    input_variables.each do |input_variable|
      inputs.push(Variable.new(input_variable))
    end if input_variables

    output_variables = hash['output']['variables']['variable'].kind_of?(Hash) ? [hash['output']['variables']['variable']] : hash['output']['variables']['variable']

    outputs = []
    output_variables.each do |variable_hash|
      outputs.push(Variable.new(variable_hash))
    end if output_variables

    Step.new(
      name: hash['name'],
      display_name: hash['display_name'],
      description: hash['description'],
      manifest: hash['manifest'],
      inputs: inputs,
      outputs: outputs
    )
  end

  def self.find_by_name name
    Xml.steps.each { |step| return step if step.name == name }
  end

end
