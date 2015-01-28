class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.string :name
      t.string :display_name
      t.text :description
      t.string :icon, default: 'medicalkit'
      t.string :kind, default: 'callback'
      t.text :url

      t.timestamps
    end
  end
end
