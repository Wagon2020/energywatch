class RenameColumnsInSmartPlugs < ActiveRecord::Migration[6.0]
  def change
    rename_column :smart_plugs, :daily_array, :daily_hash
    rename_column :smart_plugs, :daily, :todays_date
  end
end
