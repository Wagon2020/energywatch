class CreateAppliances < ActiveRecord::Migration[6.0]
  def change
    create_table :appliances do |t|
      t.string :type
      t.float :energy_performance
      t.references :user, null: false, foreign_key: true
      t.references :smart_home_system, null: false, foreign_key: true

      t.timestamps
    end
  end
end
