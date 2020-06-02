class AddReferenceToUtilityAccount < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :utility_account, foreign_key: true
  end
end
