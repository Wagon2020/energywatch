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

  def receive
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

  def forecast_renewable
    @doc_type = "A69"
    @process_type = "A01"
    url_all = "#{@base_url}securityToken=#{@token}&documentType=#{@doc_type}&processType=#{@process_type}&in_Domain=#{@domain}&periodStart=#{@date_start}&periodEnd=#{@date_end}"
    url = open(url_all)
    data = Hash.from_xml(url)
    energy_array = data["GL_MarketDocument"]["TimeSeries"]
    output = {}
    energy_array.each do |entry|
      if entry["inBiddingZone_Domain.mRID"]
        output[entry["MktPSRType"]["psrType"]] = entry["Period"]["Point"]
      end
    end

    total_array = []
    output.each do |out|
      time_entry = Time.new(2020, 1, 1, 0)
      out[1].each_with_index do |step, index|
        if total_array[index]
          old_value = total_array[index][time_entry.strftime("%k:%M")].to_i
          new_value = step["quantity"].to_i
          total_array[index][time_entry.strftime("%k:%M")] = (old_value + new_value).to_s
        else
          total_array << { time_entry.strftime("%k:%M") => step["quantity"].to_i }
        end
        time_entry += 15.minutes
      end
    end
    output["total"] = total_array
    store_forecast(output)
  end

  private

  def store_forecast(data)
    new_forecast = Forecast.new(solar: JSON(data["B16"]),
                                wind_offshore: JSON(data["B18"]),
                                wind_onshore: JSON(data["B19"]),
                                total_renewable: JSON(data["total"]))
    new_forecast.save!
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
