namespace :ew do
  desc "Receive latest data from entsoe"
  task forecast: :environment do
    EntsoeApi.new.forecast_renewable
  end
end
