class AppliancesController < ApplicationController
  def create
    @appliance = Appliance.new(appliance_params)
    @appliance.user = current_user

    if @appliance.save
      redirect_to profile_path, notice: 'Appliance was successfully created.'
    else
      redirect_to profile_path, notice: 'Error: No information entered.'
    end
  end

  def index
    @appliance = Appliance.all
  end

  def edit
    @appliance = Appliance.find(params[:id])
  end

  def update
    @appliance = Appliance.find(params[:id])
    @appliance.update(appliance_params)

    redirect_to profile_path
  end

  def destroy
    @appliance = Appliance.find(params[:id])
    @appliance.destroy

    redirect_to profile_path
  end

  private

  def appliance_params
    params.require(:appliance).permit(:appliance_type, :energy_performance, :energy_consumption)
  end

  def profile_requirements
    @smart_home_system = SmartHomeSystem.new
    @utility_account = UtilityAccount.new
    @energy_providers = EnergyProvider.all
    @energy_provider = EnergyProvider.new
  end
end
