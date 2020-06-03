require 'open-uri'

class EntsoeApi
  def initialize
    @base_url = "https://transparency.entsoe.eu/api?"
    @token = "dfb276c1-986a-4e92-a736-74d584bb782c" # TODO: use ENV
    @doc_type = "A75"
    @process_type = "A16"
    @psrs = { biomass: "B01", fossil_brown_coal: "B02", fossil_gas: "B04", wind_offshore: "B18", wind_onshore: "B19" }
    @domain = "10Y1001A1001A83F"
    @date_start = Date.yesterday.to_s.delete('-') + '2200' # returns "202006022200"
    @date_end = Date.today.to_s.delete('-') + '2200' # returns "202006022200"
  end

  def call_latest
    # @psr = psr[:psr] # biomass, wind_onshore returns in and out
    @url_all = "#{@base_url}securityToken=#{@token}&documentType=#{@doc_type}&processType=#{@process_type}&in_Domain=#{@domain}&periodStart=#{@date_start}&periodEnd=#{@date_end}"
    # @url = "#{@base_url}securityToken=#{@token}&documentType=#{@doc_type}&processType=#{@process_type}&psrType=#{@psr}&in_Domain=#{@domain}&periodStart=#{@date_start}&periodEnd=#{@date_end}"
    url = open(@url_all)
    data = Hash.from_xml(url)
    if data["GL_MarketDocument"]["TimeSeries"][0]
      internal = data["GL_MarketDocument"]["TimeSeries"][0]["Period"]
    else
      internal = data["GL_MarketDocument"]["TimeSeries"]["Period"]
    end
    # resolution = internal["resolution"]
    # entry_array = internal["Point"]
    # latest = entry_array.last
    # values = { value: latest, energy: psr[:energy] }
    data
    raise
  end

  def call_all
    all_energy = {}
    all_energy.store(biomass)
    all_energy.store(fossil_brown_coal)
    all_energy
  end

  def biomass
    call_latest({ energy: "biomass", psr: "B01" })
  end

  def fossil_brown_coal
    call_latest({ energy: "fossil brown coal", psr: "B02" })
  end
end

# bidding_zone = "10Y1001A1001A83F"  --> in_Domain

# document_type = "A69"

# business_type = "A25"

# # this returns generated capacity (wind offshore 2020/06/02):
# # https://transparency.entsoe.eu/api?securityToken=dfb276c1-986a-4e92-a736-74d584bb782c&documentType=A75&processType=A16&psrType=B18&in_Domain=10Y1001A1001A83F&periodStart=202006012200&periodEnd=202006022300

# psr = Type of Energy source
