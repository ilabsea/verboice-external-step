class Step
  attr_accessor :name, :display_name, :icon, :type

  def initialize
    @icon = 'medicalkit'
    @type = 'callback'
  end

  def config_settings
    raise 'You need to redefine this in your class'
  end

  def config_response
    raise 'You need to redefine this in your class'
  end

  def self.create_definition_with(name:)
    definition_type(name: name).new
  end

  def self.create_definitions_with(name:)
    name.split(",").map { |definition_name| create_definition_with(name: definition_name) }
  end

  def self.definition_type(name:)
    step_name = name.camelize
    "Steps::#{step_name}".constantize
  end
end
