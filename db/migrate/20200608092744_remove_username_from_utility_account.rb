class RemoveUsernameFromUtilityAccount < ActiveRecord::Migration[6.0]
  def change
    remove_column :utility_accounts, :username
  end
end
