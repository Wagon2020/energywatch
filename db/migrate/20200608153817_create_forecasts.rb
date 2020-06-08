class CreateForecasts < ActiveRecord::Migration[6.0]
  def change
    create_table :forecasts do |t|
      t.string :solar
      t.string :wind_offshore
      t.string :wind_onshore
      t.string :total_renewable
      t.string :total

      t.timestamps
    end
  end
end
