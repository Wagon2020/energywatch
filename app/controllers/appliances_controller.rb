class AppliancesController < ApplicationController
  def create
    @appliance = Appliance.new(appliance_params)
    @appliance.user = current_user

    if @appliance.save
      redirect_to profile_path, notice: 'Appliance was successfully created.'
    else
      render :new
    end
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
    params.require(:appliance).permit(all_params)
  end
end
