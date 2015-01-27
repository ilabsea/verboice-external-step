class RemoveDeviseUsers < ActiveRecord::Migration
  def change
  	drop_table :users do |t|
  	end
  end
end
