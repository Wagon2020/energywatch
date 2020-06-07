class AddYesterdayToSmartPlug < ActiveRecord::Migration[6.0]
  def change
    add_column :smart_plugs, :yesterday, :integer
  end
end
