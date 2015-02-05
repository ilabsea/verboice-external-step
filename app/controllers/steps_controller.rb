class StepsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:manifest, :result]
  skip_before_action :verify_authenticity_token, only: [:manifest, :result]

  def index
    @steps = current_access.steps
  end

  def edit
    @ratings = PeriodRating.all if params[:id] == Step::PERIOD_RATING
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
    is_valid = false
    step = Step.find_by_name(params[:id])

    if params[:step][:project_id].present? && params[:step][:variable_id].present?
      if step.update_attributes(protected_project_params)
        is_valid = true
      end
    end

    if is_valid
      redirect_to edit_step_path(step.name), notice: "Step #{params[:id]} has been updated"
    else
      redirect_to edit_step_path(step.name), alert: 'Project and variable is required'
    end
  end

  def destroy_project
    step = Step.find_by_name(params[:id])
    if step.update_attributes(project_id: nil)
      redirect_to edit_step_path(step.name), notice: "Step #{params[:id]}'s project has been removed"
    end
  end

  def sync_with_project_variable
    step = Step.find_by_name(params[:id])
    period_rating = PeriodRating.find(protected_sync_params)
    if step.project_id && step.variable_id
      period_rating.sync_numbers_with! project_id: step.project_id, variable_id: step.variable_id
      redirect_to edit_step_path(step.name), notice: "Rating's numbers has been synchronized"
    else
      redirect_to edit_step_path(step.name), alert: "Please update project and variable before synchronize"
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
    params.require(:step).permit(:project_id, :variable_id)
  end

  def protected_sync_params
    params.require(:period_rating_id)
  end

end
