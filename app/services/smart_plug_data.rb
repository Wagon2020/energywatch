class SmartPlugData
  def initialize
  end

  def self.smart_plug_monthly_array
    {
      'may 14' => 877,
      'may 15' => 893,
      'may 16' => 11,
      'may 17' => 788,
      'may 18' => 1112,
      'may 19' => 921,
      'may 20' => 808,
      'may 21' => 893,
      'may 22' => 871,
      'may 23' => 959,
      'may 24' => 1019,
      'may 25' => 1110,
      'may 26' => 947,
      'may 27' => 9406,
      'may 28' => 1037,
      'may 29' => 1119,
      'may 30' => 1302,
      'may 31' => 852,
      'june 01' => 981,
      'june 02' => 961,
      'june 03' => 798,
      'june 04' => 1299,
      'june 05' => 1520,
      'june 06' => 1062,
      'june 07' => 1341,
      'june 08' => 931,
      'june 09' => 861,
      'june 10' => 1450,
      'june 11' => 1532,
    }
  end

  def self.yesterday
    data_hash(Date.today.to_s.delete('-').to_i - 1)
  end

  def self.today
    # data_hash(Date.today.to_s.delete('-').to_i)
    data_hash(20200611)
  end

  def self.last_30_days
    number_of_days = 5
    start_date = Date.today.to_s.delete('-').to_i
    end_date = (Date.today - number_of_days.days).to_s.delete('-').to_i
    result = SmartPlug.where(todays_date: end_date..start_date)
    result
  end

  def self.household_monthly_array
    {
      'may 12' => 12,
      'may 13' => 9,
      'may 14' => 10,
      'may 15' => 8,
      'may 16' => 9,
      'may 17' => 7,
      'may 18' => 11,
      'may 19' => 11,
      'may 20' => 11,
      'may 21' => 8,
      'may 22' => 9,
      'may 23' => 14,
      'may 24' => 9,
      'may 25' => 8,
      'may 26' => 8,
      'may 27' => 8,
      'may 28' => 13,
      'may 29' => 9,
      'may 30' => 9,
      'may 31' => 11,
      'june 01' => 9,
      'june 02' => 10,
      'june 03' => 12,
      'june 04' => 9,
      'june 05' => 12,
      'june 06' => 9,
      'june 07' => 12,
      'june 08' => 9,
      'june 09' => 10,
      'june 10' => 7,
      'june 11' => 9
    }
  end

  private

  def self.data_hash(date)
    result = SmartPlug.where(todays_date: date)[0].daily_hash
    JSON(result)
  end

end
