class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :details, :data]

  def home
    @data = EntsoeData.energy_types
    @donut = EntsoeData.donut
    gon.donut_data = EntsoeData.donut_array
    gon.chart_data = EntsoeData.energy_types_array
  end

  def details
    @data = EntsoeData.energy_types
    @donut = EntsoeData.donut
    gon.donut_data = EntsoeData.donut_array
    gon.chart_data = EntsoeData.energy_types_array
  end

  def data
    @data = EntsoeData.energy_types
    @donut = EntsoeData.donut
    gon.donut_data = EntsoeData.donut_array
    gon.chart_data = EntsoeData.energy_types_array
  end
end
