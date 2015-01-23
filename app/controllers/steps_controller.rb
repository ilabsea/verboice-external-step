class StepsController < ApplicationController
	skip_before_action :authenticate_user!, only: [:manifest, :result]
  skip_before_action :verify_authenticity_token, only: [:manifest, :result]

	def index
		@steps = Xml.steps
	end

	def edit
		@step = Xml::StepNode.find_by_name(params[:id])
	end

	def update
		if params[:id] == Xml::StepNode::DETECT_MOBILE_OPERATOR
			params[:prefix].each do |operator_name, value|
				if value
					operator = Operator.find_by_name(operator_name)
					prefixes = value.split(Operator::SEPERATOR_DELIMETER)
					operator.update_attributes(prefixes: prefixes) unless prefixes.empty?
				end
			end
		end
		redirect_to steps_path, notice: "Step #{params[:id]} has been updated"
	end

	def manifest
	 	@step = Step.create_definition_with(name: params[:id])
	end

  def result
    datas = Step.definition_type(name: params[:id]).response(params)
    render json: datas
  end

end