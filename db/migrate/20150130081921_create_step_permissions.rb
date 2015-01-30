class CreateStepPermissions < ActiveRecord::Migration
  def change
    create_table :step_permissions do |t|
      t.references :step, index: true
      t.integer :user_id
      t.string :user_email

      t.timestamps
    end
  end
end
