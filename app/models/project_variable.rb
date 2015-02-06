class ProjectVariable
  def self.get(project_id, id)
    project_variables = Service::ProjectVariable.fetch_by(project_id)

    project_variables.select { |project_variable| project_variable if project_variable.id == id } .first
  end
end
