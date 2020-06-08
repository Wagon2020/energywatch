class RemoveEnergyPerformanceFromAppliances < ActiveRecord::Migration[6.0]
  def change
    remove_column :appliances, :energy_performance, :string
  end
end
