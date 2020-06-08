class SmartHomeSystemsController < ApplicationController
  def create
    @smart_home_system = SmartHomeSystem.new(smart_home_system_params)
    @smart_home_system.user = current_user

    if @smart_home_system.save
      redirect_to profile_path, notice: 'Smart home system successfully connected.'
    else
      redirect_to profile_path, notice: 'Error: No information entered.'
    end
  end

  def edit
    @smart_home_system = SmartHomeSystem.find(params[:id])
  end

  def update
    @smart_home_system = SmartHomeSystem.find(params[:id])
    @smart_home_system.update(smart_home_system_params)

    redirect_to profile_path
  end

  def destroy
    @smart_home_system = SmartHomeSystem.find(params[:id])
    @smart_home_system.destroy

    redirect_to profile_path
  end

  private

  def smart_home_system_params
    params.require(:smart_home_system).permit(:name, :system_type, :username, :password)
  end

  def profile_requirements
    @appliance = Appliance.new
    @utility_account = UtilityAccount.new
    @energy_providers = EnergyProvider.all
    @energy_provider = EnergyProvider.new
  end
end
