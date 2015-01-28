class CreateStepVariables < ActiveRecord::Migration
  def change
    create_table :step_variables do |t|
      t.string :name
      t.string :display_name
      t.text :description
      t.string :kind
      t.string :direction

      t.integer :step_id

      t.timestamps
    end
  end
end
