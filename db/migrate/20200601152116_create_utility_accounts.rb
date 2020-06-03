class CreateUtilityAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :utility_accounts do |t|
      t.string :email
      t.string :username
      t.string :password
      t.string :meter_ref
      t.references :energy_provider,foreign_key: true

      t.timestamps
    end
  end
end
