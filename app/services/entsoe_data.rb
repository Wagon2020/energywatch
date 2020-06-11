class EntsoeData
  def initialize
  end

  def self.donut
    data = energy_types
    renewable_sum = 0
    fossil_sum = 0
    other_sum = 0
    nuclear_sum = data["nuclear"]
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
      "The electricity mix is about as green as it gets. Now is the best time to use all that renewable power!"
    elsif renewable_share > 20
      "The electricity mix is not so bad right now, but it is even greener at other times of the day! Check out our forecast below:"
    else
      "There is a lot of coal in the electricity mix now - perhaps think about turning on your washing machine a bit later?"
    end
  end

  def self.energy_types
    data = EnergyMix.last
    { "biomass" => data.biomass,
      "fossil brown coal" => data.fossil_brown_coal,
      "fossil gas" => data.fossil_gas,
      "fossil hard coal" => data.fossil_hard_coal,
      "fossil oil" => data.fossil_oil,
      "geothermal" => data.geothermal,
      "hydro pumped storage" => data.hydro_pumped_storage,
      "hydro run of river poundage" => data.hydro_run_of_river_poundage,
      "hydro water reservoir" => data.hydro_water_reservoir,
      "nuclear" => data.nuclear,
      "other renewable" => data.other_renewable,
      "solar" => data.solar,
      "waste" => data.waste,
      "wind offshore" => data.wind_offshore,
      "wind onshore" => data.wind_onshore,
      "other" => data.other }
  end

  def self.created_at
    EnergyMix.last.created_at
  end

  def self.energy_types_array
    energy_types.map { |fueltype, quantity| [fueltype, quantity] }
  end

  def self.forecast_total
    forecast_reformat(JSON(Forecast.last.total_renewable))
  end

  def self.forecast_solar
    forecast_reformat(JSON(Forecast.last.solar))
  end

  def self.forecast_wind_offshore
    forecast_reformat(JSON(Forecast.last.wind_offshore))
  end

  def self.forecast_wind_onshore
    forecast_reformat(JSON(Forecast.last.wind_onshore))
  end

  def self.renewable_breakdown
    [
      { name: "offshore-wind", data: forecast_wind_offshore, stack: "renewable" },
      { name: "onshore-wind", data: forecast_wind_onshore, stack: "renewable" },
      { name: "solar", data: forecast_solar, stack: "renewable" }
    ]
  end

  def self.forecast_recommendation
    re = forecast_total
    max = re.max_by { |_k, v| v }
    range = re.select { |k, _v| re[k] >= (0.8 * max[1]).round }
    # "Best time is between #{range.first[0]} and #{range.to_a.last[0]}."
  end

  def self.forecast_min
    forecast_total.min_by { |_k, v| v }
  end

  def self.forecast_max
    forecast_total.max_by { |_k, v| v }
  end

  private

  def self.forecast_reformat(data)
    data.reduce({}) do |m, e|
      e.each { |k, v| m[k] = v.to_i }; m
    end
  end

  def self.renewable
    # ["B01", "B09", "B10", "B11", "B12", "B13", "B15", "B16", "B18", "B19"]
    ["biomass",
     "geothermal",
     "hydro pumped storage",
     "hydro run of river poundage",
     "hydro water reservoir",
     "other renewable",
     "solar",
     "wind offshore",
     "wind onshore"]
  end

  def self.fossil
    # ["B02", "B03", "B04", "B05", "B06", "B07", "B08"]
    ["fossil brown coal",
     "fossil gas",
     "fossil hard coal",
     "fossil oil"]
  end

  def self.nuclear
    # ["B14"]
    ["nuclear"]
  end

  def self.other
    # ["B17", "B20"]
    ["waste", "other"]
  end
end
