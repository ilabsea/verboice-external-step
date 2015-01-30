class ProjectsController < ApplicationController
  def index
    conditions = {}
    conditions[:account_id] = params[:account_id] if(params[:account_id])
    @channels  = Service::Channel.all(conditions)
    
    respond_to do |format|
      format.json { render json: @channels}
    end

  end
end
