require 'open-uri'
# require 'nokogiri'

class EntsoeApi
  def initialize
    @base_url = "https://transparency.entsoe.eu/api?"
    @token = "securityToken=dfb276c1-986a-4e92-a736-74d584bb782c"
    @doc_type = "A75"
    @process_type = "A16"
    @psr = "B18"
    @domain = "10Y1001A1001A83F"
    @p_start = "202006010000"
    @p_end = "202006012300"
    @actual = "https://transparency.entsoe.eu/api?securityToken=dfb276c1-986a-4e92-a736-74d584bb782c&documentType=A75&processType=A16&psrType=B18&in_Domain=10Y1001A1001A83F&periodStart=202006010000&periodEnd=202006012300"
    @url = "#{@base_url}#{@token}&documentType=#{@doc_type}&processType=#{@process_type}&psrType=#{@psr}&in_Domain=#{@domain}&periodStart=#{@p_start}&periodEnd=#{@p_end}"
  end

  def call
    url = open(@url)
    data = Hash.from_xml(url)
    data["GL_MarketDocument"]
    time_period = data["GL_MarketDocument"]["time_Period.timeInterval"]
    internal = data["GL_MarketDocument"]["TimeSeries"]["Period"]
    resolution = data["GL_MarketDocument"]["TimeSeries"]["Period"]["resolution"]
    entry_array = data["GL_MarketDocument"]["TimeSeries"]["Period"]["Point"]

    p data
    # binding.pry
    data
  end
end




# document = Nokogiri::XML(url)
# puts document

# intervalls = document.xpath("//quantity")
# p intervalls

# document.root.xpath('time_Period.timeInterval').each do |period|
#   puts period
#   # name = period.xpath('name').text

#   # puts "#{name}, a #{appearance} beer from #{origin}"
# end

# bidding_zone = "10Y1001A1001A83F"

# document_type = "A69"

# business_type = "A25"

# in_Domain =

# /api?documentType=A78&businessType=A53&in_Domain=10YCZ-CEPS-----N&out_Domain=10YSK-SEPS-----K&periodStart=201512312300&periodEnd=201612312300

# # this returns generated capacity (wind offshore 2020/06/02):
# # https://transparency.entsoe.eu/api?securityToken=dfb276c1-986a-4e92-a736-74d584bb782c&documentType=A75&processType=A16&psrType=B18&in_Domain=10Y1001A1001A83F&periodStart=202006012200&periodEnd=202006022300

# psr = Type of Energy source
