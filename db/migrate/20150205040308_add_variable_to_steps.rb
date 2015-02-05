class AddVariableToSteps < ActiveRecord::Migration
  def change
    add_column :steps, :variable_id, :integer
  end
end
