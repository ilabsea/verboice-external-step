class StepsController < ApplicationController
	skip_before_action :authenticate_user!, only: [:manifest, :result]
  skip_before_action :verify_authenticity_token, only: [:manifest, :result]

	def index
		@steps = current_access.steps
	end

	def edit
    @ratings = IloRating.all if params[:id] == Step::ILO_RATING
    @operators = Operator.all if params[:id] == Step::DETECT_MOBILE_OPERATOR
		@step = Step.find_by_name(params[:id])
	end

	def update
		if params[:id] == Step::DETECT_MOBILE_OPERATOR
			Operator.update_prefix_setting operators: params[:operators]
		end

		redirect_to steps_path, notice: "Step #{params[:id]} has been updated"
	end

	def update_project
		step = Step.find_by_name(params[:id])
		if step.update_attributes(protected_project_params)
			redirect_to steps_path, notice: "Step #{params[:id]} has been updated"
		else
			flash.now[:alert] = 'Fail to update project'
			render :edit
		end
	end

	def destroy_project
		step = Step.find_by_name(params[:id])
		if step.update_attributes(project_id: nil)
			redirect_to steps_path, notice: "Step #{params[:id]}'s project has been removed"
		end
	end

	def manifest
		@step = Step.find_by_name(params[:id])
	end

  def result
    render json: Step.type(name: params[:id]).response(params)
  end

  private

  def protected_project_params
  	params.require(:step).permit(:project_id)
  end

end
