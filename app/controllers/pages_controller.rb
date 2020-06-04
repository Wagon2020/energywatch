class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :data]

  def home
    @data = EntsoeApi.new.energy_types
    @donut = EntsoeApi.new.donut
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
    @data = EntsoeApi.new.energy_types
    @donut = EntsoeApi.new.donut
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

  def store
    EntsoeApi.new.store_latest_call
  end

end
