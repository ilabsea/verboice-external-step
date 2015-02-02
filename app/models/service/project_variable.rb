class Service::ProjectVariable < ActiveApi
  attribute :id, Integer
  attribute :name, String

  @@project_variables = {}

  def self.collection project_id:
  	project_id ? fetch_by(project_id: project_id).map { |variable| [variable.name, variable.id] } : []
  end

  def self.fetch_by project_id:
  	@@project_variables[project_id] || get_variables(project_id: project_id)
  end

  def self.get_variables project_id:
  	@@project_variables[project_id] = project_id ? where(project_id: project_id) : []
  end

end
