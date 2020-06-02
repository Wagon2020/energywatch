class AddConsumptionToConsumptionEntries < ActiveRecord::Migration[6.0]
  def change
    add_reference :consumption_entries, :consumption, polymorphic: true, null: false, index: { name: :idx_consumption }
  end
end
