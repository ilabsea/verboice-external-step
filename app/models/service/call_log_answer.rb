class Service::CallLogAnswer < ActiveApi
  attribute :project_variable_id
  attribute :value
  attribute :call_log

  def self.fetch_by project_id:, variable_id:, from:, to:
  	where(project_id: project_id, variable_id: variable_id, from: from, to: to)
  end

end
