class AddReferenceToUtilityAccount < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :utility_account, null: false, foreign_key: true
  end
end
