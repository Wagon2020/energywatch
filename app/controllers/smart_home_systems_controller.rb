class SmartHomeSystemsController < ApplicationController
  def create
    @smart_home_system = SmartHomeSystem.new(smart_home_system_params)
    @smart_home_system.user = current_user

    if @smart_home_system.save
      redirect_to profile_path, notice: 'Smart home system successfully connected.'
    else
      render :new
    end
  end

  private

  def smart_home_system_params
    params.require(:smart_home_system).permit(:name, :system_type, :username, :password)
  end
end
