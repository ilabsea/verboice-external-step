class PeriodRatingsController < ApplicationController
  add_breadcrumb "Steps", :steps_path

  def index
    redirect_to edit_step_path(Step::PERIOD_RATING)
  end

  def new
    @step = Step.find_by_name Step::PERIOD_RATING
    @rating = PeriodRating.new step_id: @step.id

    append_breadcrumbs 'New'
  end

  def edit
    @rating = PeriodRating.find(params[:id])

    append_breadcrumbs 'Edit'
  end

  def create
    @rating = PeriodRating.new(protected_advance_params)

    append_breadcrumbs 'New'

    if @rating.save
      redirect_to edit_step_path(@rating.step.name), notice: 'Rating has been created'
    else
      flash.now[:alert] = error_for @rating
      render :new, period_rating: @rating
    end
  end

  def update
    @rating = PeriodRating.find(params[:id])

    append_breadcrumbs 'Edit'

    if @rating.update_attributes(protected_advance_params)
      redirect_to edit_step_path(@rating.step.name), notice: 'Rating has been updated'
    else
      flash.now[:alert] = error_for @rating
      render :edit
    end
  end

  def destroy
    @rating = PeriodRating.find(params[:id])
    if @rating.destroy
      redirect_to edit_step_path(@rating.step.name), notice: 'Rating has been deleted'
    end
  end

  private

  def protected_advance_params
    params.require(:period_rating).permit(:step_id, :from_date, :to_date, :code, :description)
  end

  def append_breadcrumbs current_action
    add_breadcrumb @rating.step.display_name, edit_step_path(@rating.step.name)
    add_breadcrumb current_action
  end

  def error_for record
    record.errors.full_messages.first
  end

end
