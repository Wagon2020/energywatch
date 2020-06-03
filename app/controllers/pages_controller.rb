class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :data]

  def home
  end

  def details
  end

  def data
    @data = EntsoeApi.new.energy_types
    @donut = EntsoeApi.new.donut
  end

  def store
    EntsoeApi.new.store_latest_call
  end

end
