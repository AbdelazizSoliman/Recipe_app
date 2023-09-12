class RemoveUnitAndRenameMeasurementInFoods < ActiveRecord::Migration[7.0]
  def up
    remove_column :foods, :unit
    rename_column :foods, :measurement, :measurement_unit
  end

  def down
    rename_column :foods, :measurement_unit, :measurement
    add_column :foods, :unit, :string
  end
end
