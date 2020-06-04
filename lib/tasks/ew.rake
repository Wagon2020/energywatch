namespace :ew do
  desc "Receive latest data from entsoe"
  task entsoe_call: :environment do
    EntsoeApi.new.receive
  end

end
