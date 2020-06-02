class AddUserToUtilityAccount < ActiveRecord::Migration[6.0]
  def change
    add_reference :utility_accounts, :user, index: true
  end
end
