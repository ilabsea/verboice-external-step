class Xml
	path = File.join(Rails.root, 'config', 'steps.xml')
  @@steps_xml = File.exists?(path) ? Nokogiri::XML(File.open(path)) : nil
  @@steps = []

  def self.steps
  	return @@steps unless @@steps.empty?

  	if @@steps_xml
	  	hash = Hash.from_xml(@@steps_xml.to_xml)

	  	hash['steps']['step'].each do |step_hash|
	  		@@steps.push StepNode.from_hash(step_hash)
	  	end
	  end

  	@@steps
  end

  class StepNode
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
        inputs.push(StepVariable.new(input_variable))
      end if input_variables

      output_variables = hash['output']['variables']['variable'].kind_of?(Hash) ? [hash['output']['variables']['variable']] : hash['output']['variables']['variable']

      outputs = []
      output_variables.each do |variable_hash|
        outputs.push(StepVariable.new(variable_hash))
      end if output_variables

      StepNode.new(
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

end
