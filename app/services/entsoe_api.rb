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
    output
  end

  def energy_types
    { biomass: "B01", fossil_brown_coal: "B02", fossil_gas: "B04", wind_offshore: "B18", wind_onshore: "B19" }
  end
end
