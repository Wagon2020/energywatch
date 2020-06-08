class AddColumnToAppliances < ActiveRecord::Migration[6.0]
  def change
    add_column :appliances, :energy_performance, :string
  end
end
