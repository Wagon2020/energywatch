class CreateEnergyMixes < ActiveRecord::Migration[6.0]
  def change
    create_table :energy_mixes do |t|
      t.integer :biomass
      t.integer :fossil_brown_coal
      t.integer :fossil_gas
      t.integer :fossil_hard_coal
      t.integer :fossil_oil
      t.integer :geothermal
      t.integer :hydro_pumped_storage
      t.integer :hydro_run_of_river_poundage
      t.integer :hydro_water_reservoir
      t.integer :nuclear
      t.integer :other_renewable
      t.integer :solar
      t.integer :waste
      t.integer :wind_offshore
      t.integer :wind_onshore
      t.integer :other
      t.string :api_time

      t.timestamps
    end
  end
end
