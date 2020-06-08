class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :details, :data]

  def home
    @data = EntsoeData.energy_types
    @donut = EntsoeData.donut
    @sp = SmartPlugData.smart_plug_monthly_array
    gon.donut_data = EntsoeData.donut_array
    gon.chart_data = EntsoeData.energy_types_array
    gon.smart_plug_data = SmartPlugData.smart_plug_monthly_array
    @re = EntsoeData.renewable_share
  end

  def details
    @data = EntsoeData.energy_types
    @donut = EntsoeData.donut
    gon.donut_data = EntsoeData.donut_array
    gon.chart_data = EntsoeData.energy_types_array
    gon.smart_plug_data = SmartPlugData.smart_plug_monthly_array
  end

  def data
    @smart_today = SmartPlugData.today
    @smart_yesterday = SmartPlugData.yesterday
    @data_created_at = EntsoeData.created_at
    @data = EntsoeData.energy_types
    @donut = EntsoeData.donut
    gon.donut_data = EntsoeData.donut_array
    gon.chart_data = EntsoeData.energy_types_array
    gon.smart_plug_data = SmartPlugData.smart_plug_monthly_array
  end
end
