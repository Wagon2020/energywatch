class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :details, :data, :download_pdf]

  def home
    @data = EntsoeData.energy_types
    @donut = EntsoeData.donut
    @sp = SmartPlugData.smart_plug_monthly_array
    gon.donut_data = EntsoeData.donut_array
    @re = EntsoeData.renewable_share
  end

  def details
    @data = EntsoeData.energy_types
    @donut = EntsoeData.donut
    @forecast_rec = EntsoeData.forecast_recommendation # returns string with range of time for best re
    @forecast_max = EntsoeData.forecast_max
    @forecast_min = EntsoeData.forecast_min
    @recommendations = EntsoeData.recommendations
    gon.donut_data = EntsoeData.donut_array
    gon.chart_data = EntsoeData.energy_types_array
    gon.smart_plug_data = SmartPlugData.smart_plug_monthly_array

    gon.renewable_forecast = EntsoeData.forecast_total
    gon.re_breakdown_data = EntsoeData.renewable_breakdown
  end

  def data
    @smart_today = SmartPlugData.today
    @smart_yesterday = SmartPlugData.yesterday
    @data_created_at = EntsoeData.created_at
    @data = EntsoeData.energy_types
    @donut = EntsoeData.donut
    @renewable_forecast = EntsoeData.forecast_total
    @solar_forecast = EntsoeData.forecast_solar # returns Hash of the latest renewable forecast (summed up)
    @household = SmartPlugData.household_monthly_array

    gon.donut_data = EntsoeData.donut_array
    gon.chart_data = EntsoeData.energy_types_array
    gon.smart_plug_data = SmartPlugData.smart_plug_monthly_array
    gon.renewable_forecast = EntsoeData.forecast_total
    gon.re_breakdown_data = EntsoeData.renewable_breakdown
  end

  def download_pdf
    send_file(
      "#{Rails.root}/app/assets/images/fluter70_klima_poster.pdf",
      filename: "fluter70_klima_poster.pdf",
      type: "application/pdf"
    )
    # redirect_to root_path
  end

  private

  # delete method once forecast data is in place
  def self.test_data
    [
      { name: "Workout", data: { "2017-01-01": 3, "2017-01-02": 4 } },
      { name: "Call parents", data: { "2017-01-01": 5, "2017-01-02": 3 } }
    ]
  end
end
