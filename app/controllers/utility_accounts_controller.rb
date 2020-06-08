class UtilityAccountsController < ApplicationController
  def create
    @utility_account = UtilityAccount.new(utility_account_params)
    @utility_account.user = current_user

    if @utility_account.save
      redirect_to profile_path, notice: 'Utility account successfully connected.'
    else
    redirect_to profile_path, notice: 'Error: No information entered.'
    end
  end

  def edit
    @utility_account = UtilityAccount.find(params[:id])
  end

  def update
    @utility_account = UtilityAccount.find(params[:id])
    @utility_account.update(utility_account_params)

    redirect_to profile_path
  end

  def destroy
    @utility_account = UtilityAccount.find(params[:id])
    @utility_account.destroy

    redirect_to profile_path
  end

  private

  def utility_account_params
    params.require(:utility_account).permit(:email, :username, :password, :meter_ref, :energy_provider_id)
  end

  def profile_requirements
    @appliance = Appliance.new
    @smart_home_system = SmartHomeSystem.new
    @energy_providers = EnergyProvider.all
    @energy_provider = EnergyProvider.new
  end
end
