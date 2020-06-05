class AddDailyArrayToSmartPlug < ActiveRecord::Migration[6.0]
  def change
    add_column :smart_plugs, :daily_array, :string
  end
end
