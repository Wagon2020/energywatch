class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @data = EntsoeApi.new.call_latest
  end

end
