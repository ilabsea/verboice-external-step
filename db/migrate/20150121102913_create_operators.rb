class CreateOperators < ActiveRecord::Migration
  def change
    create_table :operators do |t|
      t.string :name
      t.integer :code
      t.text :prefixes

      t.timestamps
    end

    add_index :operators, :name, unique: true
  end
end
