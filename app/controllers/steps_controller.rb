class StepsController < ApplicationController
	skip_before_action :authenticate_user!, only: [:manifest, :result]
  skip_before_action :verify_authenticity_token, only: [:manifest, :result]

	def index
		@steps = Step.all
	end

	def edit
		@step = Step.find_by_name(params[:id])
	end

	def update
		if params[:id] == Step::DETECT_MOBILE_OPERATOR
			Operator.update_prefix_setting operators: params[:operators]
		end

		redirect_to steps_path, notice: "Step #{params[:id]} has been updated"
	end

	def manifest
		@step = Step.find_by_name(params[:id])
	end

  def result
    render json: Step.type(name: params[:id]).response(params)
  end

end
