class EnergyProvidersController < ApplicationController
  def create
    @energy_provider = EnergyProvider.new(energy_provider_params)

    if @energy_provider.save
      redirect_to profile_path, notice: 'Energy provider successfully added.'
    else
      render :new
    end
  end

  private

  def energy_provider_params
    params.require(:energy_provider).permit(:name, :url)
  end
end
