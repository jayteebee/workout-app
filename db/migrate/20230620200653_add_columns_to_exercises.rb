class AddColumnsToExercises < ActiveRecord::Migration[7.0]
  def change
    add_column :exercises, :equipment_used, :string
    add_column :exercises, :primary_muscles, :string, array: true, default: []
    add_column :exercises, :secondary_muscles, :string, array: true, default: []

  end
end
