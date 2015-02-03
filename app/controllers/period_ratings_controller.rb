class PeriodRatingsController < ApplicationController
  def new
    @step = Step.find_by_name Step::PERIOD_RATING
    @rating = PeriodRating.new step_id: @step.id
  end

  def edit
    @rating = PeriodRating.find(params[:id])
  end

  def create
    @rating = PeriodRating.new(protected_advance_params)
    if @rating.save
      redirect_to edit_step_path(@rating.step.name), notice: 'Rating has been created'
    else
      flash.now[:alert] = 'Fail to create'
      render :new, period_rating: @rating
    end
  end

  def update
    @rating = PeriodRating.find(params[:id])
    if @rating.update_attributes(protected_basic_params)
      redirect_to edit_step_path(@rating.step.name), notice: 'Rating has been updated'
    else
      flash.now[:alert] = 'Fail to update'
      render :edit
    end
  end

  def destroy
    @rating = PeriodRating.find(params[:id])
    if @rating.destroy
      redirect_to edit_step_path(@rating.step.name), notice: 'Rating has been deleted'
    end
  end

  def show_sync
    @rating = PeriodRating.find(params[:id])
    @variables = Service::ProjectVariable.collection project_id: @rating.step.project_id
  end

  def sync
    @rating = PeriodRating.find(params[:id])
    if protected_sync_params[:variable_id].present?
      @rating.sync_numbers_with(variable_id: protected_sync_params[:variable_id])
      redirect_to edit_step_path(@rating.step.name), notice: "Rating's numbers has been synchronized"
    else
      redirect_to show_sync_period_rating_path(@rating), alert: 'Please select variable to sync'
    end
  end

  private

  def protected_advance_params
    params.require(:period_rating).permit(:step_id, :client_from_date, :client_to_date, :code, :description)
  end

  def protected_basic_params
    params.require(:period_rating).permit(:code, :description)
  end

  def protected_sync_params
    params.require(:period_rating).permit(:variable_id)
  end

end