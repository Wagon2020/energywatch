class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :data]

  def home
  end

  def details
  end

  def data
    @data = EntsoeApi.new.call_latest
    @donut = EntsoeApi.new.donut
  end

end
