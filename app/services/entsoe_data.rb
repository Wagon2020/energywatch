class EntsoeData
  def initialize
  end

  def self.donut
    data = energy_types
    renewable_sum = 0
    fossil_sum = 0
    other_sum = 0
    nuclear_sum = data[:nuclear]
    data.each do |key, value|
      if renewable.include? key
        renewable_sum += value
      elsif fossil.include? key
        fossil_sum += value
      elsif other.include? key
        other_sum += value
      end
    end
    { renewable: renewable_sum, fossil: fossil_sum, other: other_sum, nuclear: nuclear_sum }
  end

  def self.donut_array
    donut.map { |fueltype, quantity| [fueltype, quantity] }
  end

  def self.energy_types
    data = EnergyMix.last
    { biomass: data.biomass,
      fossil_brown_coal: data.fossil_brown_coal,
      fossil_gas: data.fossil_gas,
      fossil_hard_coal: data.fossil_hard_coal,
      fossil_oil: data.fossil_oil,
      geothermal: data.geothermal,
      hydro_pumped_storage: data.hydro_pumped_storage,
      hydro_run_of_river_poundage: data.hydro_run_of_river_poundage,
      hydro_water_reservoir: data.hydro_water_reservoir,
      nuclear: data.nuclear,
      other_renewable: data.other_renewable,
      solar: data.solar,
      waste: data.waste,
      wind_offshore: data.wind_offshore,
      wind_onshore: data.wind_onshore,
      other: data.other }
  end

  def self.created_at
    EnergyMix.last.created_at
  end

  def self.energy_types_array
    energy_types.map { |fueltype, quantity| [fueltype, quantity] }
  end

  def self.load
    energy_types_array.sum
  end

  private

  def self.renewable
    # ["B01", "B09", "B10", "B11", "B12", "B13", "B15", "B16", "B18", "B19"]
    [:biomass,
     :geothermal,
     :hydro_pumped_storage,
     :hydro_run_of_river_poundage,
     :hydro_water_reservoir,
     :other_renewable,
     :solar,
     :wind_offshore,
     :wind_onshore]
  end

  def self.fossil
    # ["B02", "B03", "B04", "B05", "B06", "B07", "B08"]
    [:fossil_brown_coal,
     :fossil_gas,
     :fossil_hard_coal,
     :fossil_oil]
  end

  def self.nuclear
    # ["B14"]
    [:nuclear]
  end

  def self.other
    # ["B17", "B20"]
    [:waste, :other]
  end
end
