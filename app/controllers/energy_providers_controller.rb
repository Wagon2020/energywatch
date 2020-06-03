class EnergyProvidersController < ApplicationController
  def create
    @energy_provider = EnergyProvider.new(energy_provider_params)

    if @energy_provider.save
      redirect_to profile_path, notice: 'Energy provider successfully added.'
    else
      redirect_to profile_path, notice: 'Error: No information entered.'
    end
  end

  private

  def energy_provider_params
    params.require(:energy_provider).permit(:name, :url)
  end

  def profile_requirements
    @appliance = Appliance.new
    @smart_home_system = SmartHomeSystem.new
    @utility_account = UtilityAccount.new
    @energy_providers = EnergyProvider.all
  end
end
