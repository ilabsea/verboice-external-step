class StepsController < ApplicationController
	def index
		@steps = Xml.steps
	end

	def edit
		@step = Step.find_by_name(params[:id])
	end

	def update
		if params[:id] == Step::DETECT_MOBILE_OPERATOR
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

end