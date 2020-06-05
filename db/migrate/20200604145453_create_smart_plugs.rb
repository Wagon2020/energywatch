class CreateSmartPlugs < ActiveRecord::Migration[6.0]
  def change
    create_table :smart_plugs do |t|
      t.integer :actual
      t.integer :daily

      t.timestamps
    end
  end
end
