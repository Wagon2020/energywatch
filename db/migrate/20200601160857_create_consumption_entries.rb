class CreateConsumptionEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :consumption_entries do |t|
      t.float :actual_consumption

      t.timestamps
    end
  end
end
