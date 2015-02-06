class ProjectVariablesController < ApplicationController
  def index
    variables = Service::ProjectVariable.fetch_by params[:project_id]
    render json: variables
  end
end
