class RenameIloRatingToPeriodRating < ActiveRecord::Migration
  def change
    rename_table :ilo_ratings, :period_ratings
  end
end
