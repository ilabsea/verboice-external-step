class Xml
	path = File.join(Rails.root, 'config', 'steps.xml')
  @@steps_xml = File.exists?(path) ? Nokogiri::XML(File.open(path)) : nil
  @@steps = []

  def self.steps
  	return @@steps unless @@steps.empty?

  	if @@steps_xml
	  	hash = Hash.from_xml(@@steps_xml.to_xml)

	  	hash['steps']['step'].each do |step_hash|
	  		@@steps.push Step.from_hash(step_hash)
	  	end
	  end

  	@@steps
  end

end
