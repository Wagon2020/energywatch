class AddUserToSmartPlug < ActiveRecord::Migration[6.0]
  def change
    add_reference :smart_plugs, :user, null: false, foreign_key: true
  end
end
