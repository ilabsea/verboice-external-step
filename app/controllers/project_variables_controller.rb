class ProjectVariablesController < ApplicationController
  def index
    variables = Service::ProjectVariable.fetch_by project_id: params[:project_id]
    render json: variables
  end
end
