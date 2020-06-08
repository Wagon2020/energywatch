class RemoveNameFromSmartHomeSystems < ActiveRecord::Migration[6.0]
  def change
    remove_column :smart_home_systems, :name
  end
end
