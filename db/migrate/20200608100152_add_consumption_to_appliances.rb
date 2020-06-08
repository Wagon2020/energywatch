class AddConsumptionToAppliances < ActiveRecord::Migration[6.0]
  def change
    add_column :appliances, :energy_consumption, :integer
  end
end
