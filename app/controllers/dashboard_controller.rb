class DashboardController < ApplicationController
  def profile
    @user = current_user
    @appliance = Appliance.new
    @smart_home_system = SmartHomeSystem.new
    @utility_account = UtilityAccount.new
    @energy_providers = EnergyProvider.all
    @energy_provider = EnergyProvider.new
    gon.household = SmartPlugData.household_monthly_array
    gon.smart_plug_data = SmartPlugData.smart_plug_monthly_array
    gon.smart_plug_daily = SmartPlugData.yesterday
    @appliances = Appliance.where(user: current_user)
  end

  def overview
    @user = current_user
    gon.smart_plug_data = SmartPlugData.smart_plug_monthly_array
    gon.smart_plug_daily = SmartPlugData.yesterday
    gon.smart_plug_last_30_days = SmartPlugData.last_30_days
  end
end
