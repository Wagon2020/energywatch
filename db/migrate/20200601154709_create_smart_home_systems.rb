class CreateSmartHomeSystems < ActiveRecord::Migration[6.0]
  def change
    create_table :smart_home_systems do |t|
      t.string :name
      t.string :system_type
      t.string :username
      t.string :password
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
