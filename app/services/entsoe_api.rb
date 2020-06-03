require 'open-uri'

class EntsoeApi
  def initialize
    @base_url = "https://transparency.entsoe.eu/api?"
    @doc_type = "A75"
    @process_type = "A16"
    @token = ENV["securityToken"]
    @domain = "10Y1001A1001A83F"
    @date_start = Date.yesterday.to_s.delete('-') + '2200' # returns "202006022200"
    @date_end = Date.today.to_s.delete('-') + '2200' # returns "202006022200"
  end

  def call_latest
    url_all = "#{@base_url}securityToken=#{@token}&documentType=#{@doc_type}&processType=#{@process_type}&in_Domain=#{@domain}&periodStart=#{@date_start}&periodEnd=#{@date_end}"
    url = open(url_all)
    data = Hash.from_xml(url)
    energy_array = data["GL_MarketDocument"]["TimeSeries"]
    output = {}
    energy_array.each do |entry|
      if entry["inBiddingZone_Domain.mRID"]
        output[entry["MktPSRType"]["psrType"]] = entry["Period"]["Point"].last
      end
    end
    @global_data = output
    store_to_db
  end

  def donut
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

  def energy_types
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

  private

  def renewable
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

  def fossil
    # ["B02", "B03", "B04", "B05", "B06", "B07", "B08"]
    [:fossil_brown_coal,
     :fossil_gas,
     :fossil_hard_coal,
     :fossil_oil]
  end

  def nuclear
    # ["B14"]
    [:nuclear]
  end

  def other
    # ["B17", "B20"]
    [:waste, :other]
  end

  def store_to_db
    new_mix = EnergyMix.new(biomass: @global_data["B01"]["quantity"].to_i,
                            fossil_brown_coal: @global_data["B02"]["quantity"].to_i,
                            fossil_gas: @global_data["B04"]["quantity"].to_i,
                            fossil_hard_coal: @global_data["B05"]["quantity"].to_i,
                            fossil_oil: @global_data["B06"]["quantity"].to_i,
                            geothermal: @global_data["B09"]["quantity"].to_i,
                            hydro_pumped_storage: @global_data["B10"]["quantity"].to_i,
                            hydro_run_of_river_poundage: @global_data["B11"]["quantity"].to_i,
                            hydro_water_reservoir: @global_data["B12"]["quantity"].to_i,
                            nuclear: @global_data["B14"]["quantity"].to_i,
                            other_renewable: @global_data["B15"]["quantity"].to_i,
                            solar: @global_data["B16"]["quantity"].to_i,
                            waste: @global_data["B17"]["quantity"].to_i,
                            wind_offshore: @global_data["B18"]["quantity"].to_i,
                            wind_onshore: @global_data["B19"]["quantity"].to_i,
                            other: @global_data["B20"]["quantity"].to_i)
    new_mix.save!
  end
end
