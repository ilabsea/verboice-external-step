class AddStepToRating < ActiveRecord::Migration
  def change
  	add_column :ilo_ratings, :step_id, :integer
  end
end
