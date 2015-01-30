class CreateIloRatings < ActiveRecord::Migration
  def change
    create_table :ilo_ratings do |t|
      t.date :from_date
      t.date :to_date
      t.text :numbers
      t.integer :code
      t.text :description

      t.timestamps
    end
  end
end
