class CreateEnergies < ActiveRecord::Migration[6.0]
  def change
    create_table :energies do |t|
      t.string :name
      t.string :category
      t.string :amount
      t.string :time
      t.timestamps
    end
  end
end
