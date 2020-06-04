class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :data]

  def home
    @data = EntsoeData.energy_types
    @donut = EntsoeData.donut
    @donut_array = []
    @donut.each do |fueltype, quantity|
      @donut_array << [fueltype, quantity]
    end
    gon.donut_data = @donut_array
    @chart_array = []
    @data.each do |fueltype, quantity|
      @chart_array << [fueltype, quantity]
    end
    gon.chart_data = @chart_array
  end

  def details
  end

  def data
    @data = EntsoeData.energy_types
    @donut = EntsoeData.donut
    @donut_array = []
    @donut.each do |fueltype, quantity|
      @donut_array << [fueltype, quantity]
    end
    gon.donut_data = @donut_array
    @chart_array = []
    @data.each do |fueltype, quantity|
      @chart_array << [fueltype, quantity]
    end
    gon.chart_data = @chart_array
  end

end
