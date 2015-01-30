class IloRatingsController < ApplicationController
	def new
		@rating = IloRating.new
	end

	def edit
		@rating = IloRating.find(params[:id])
	end

	def create
		@rating = IloRating.new(protected_advance_params)
		if @rating.save
			redirect_to edit_step_path(Step::ILO_RATING), notice: 'Rating has been created'
		else
			flash.now[:alert] = 'Fail to create'
			render :new, ilo_rating: @rating
		end
	end

	def update
		@rating = IloRating.find(params[:id])
		if @rating.update_attributes(protected_basic_params)
			redirect_to edit_step_path(Step::ILO_RATING), notice: 'Rating has been updated'
		else
			flash.now[:alert] = 'Fail to update'
			render :edit
		end
	end

	def destroy
		@rating = IloRating.find(params[:id])
		if @rating.destroy
			redirect_to edit_step_path(Step::ILO_RATING), notice: 'Rating has been deleted'
		end
	end

	private

	def protected_advance_params
		params.require(:ilo_rating).permit(:client_from_date, :client_to_date, :code, :description)
	end

	def protected_basic_params
		params.require(:ilo_rating).permit(:code, :description)
	end

end
