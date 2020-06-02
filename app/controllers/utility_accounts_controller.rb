class UtilityAccountsController < ApplicationController
  def create
    @utility_account = UtilityAccount.new(utility_account_params)
    @utility_account.user = current_user

    if @utility_account.save
      redirect_to profile_path, notice: 'Utility account successfully connected.'
    else
      render :new
    end
  end

  private

  def utility_account_params
    params.require(:utility_account).permit(all_params)
  end
end
