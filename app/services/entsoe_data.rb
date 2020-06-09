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

  def self.renewable_share
    ((donut[:renewable].to_f / donut.values.sum) * 100).round
  end

  def self.recommendations
    if renewable_share > 40
      "The electricity mix is about as green as it gets! Now is the best time to use all that renewable power."
    elsif renewable_share > 20
      "It's not so bad, but you can be even greener!"
    else
      "Yuck, we've got a lot of coal in the mix now, better think twice!"
    end
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

  def self.forecast_renewable
    JSON(Forecast.last.total_renewable)
  end

  # method below turns array of hashes into a hash and turns all values into integers.

  def self.forecast_re_int
    EntsoeData.forecast_renewable.reduce({}) {|m,e|
      e.each{|k,v| m[k] = v.to_i}; m}
  end

  def self.forecast_recommendation
    re = EntsoeData.forecast_re_int
    range = re.select {|k, v| re[k] >= 20000}
    "Best time is between #{range.first[0]} and #{range.to_a.last[0]}."
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
