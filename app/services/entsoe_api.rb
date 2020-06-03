require 'open-uri'

class EntsoeApi
  def initialize
    @base_url = "https://transparency.entsoe.eu/api?"
    @token = "dfb276c1-986a-4e92-a736-74d584bb782c" # TODO: use ENV
    @doc_type = "A75"
    @process_type = "A16"
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
    energy_types
  end

  def donut
    call_latest
    renewable_sum = 0
    fossil_sum = 0
    other_sum = 0
    nuclear_sum = @global_data["B14"]["quantity"].to_i
    @global_data.each do |key, value|
      if renewable.include? key
        renewable_sum += value["quantity"].to_i
      elsif fossil.include? key
        fossil_sum += value["quantity"].to_i
      elsif other.include? key
        other_sum += value["quantity"].to_i
      end
    end
    { renewable: renewable_sum, fossil: fossil_sum, other: other_sum, nuclear: nuclear_sum }
  end

  private

  def renewable
    ["B01", "B09", "B10", "B11", "B12", "B13", "B15", "B16", "B18", "B19"]
  end

  def fossil
    ["B02", "B03", "B04", "B05", "B06", "B07", "B08"]
  end

  def nuclear
    "B14"
  end

  def other
    ["B17", "B20"]
  end

  def energy_types
    { biomass: @global_data["B01"]["quantity"].to_i,
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
      other: @global_data["B20"]["quantity"].to_i }
  end
end
