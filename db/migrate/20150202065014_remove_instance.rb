class RemoveInstance < ActiveRecord::Migration
  def change
    drop_table :instances do |t|

    end
  end
end
