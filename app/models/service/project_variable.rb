class Service::ProjectVariable < ActiveApi
  attribute :id, Integer
  attribute :name, String

  def self.collection(project_id:)
  	project_id ? fetch_by(project_id: project_id).map { |variable| [variable.name, variable.id] } : []
  end

  def self.fetch_by(project_id:)
  	project_id ? where(project_id: project_id) : []
  end

end
