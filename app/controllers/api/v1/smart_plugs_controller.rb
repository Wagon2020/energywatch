class Api::V1::SmartPlugsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]
  before_action :set_smart_plug, only: [ :show ]

  def create
    @smart_plug = SmartPlug.new(smart_plug_params)
    @smart_plug.user = current_user
    authorize @smart_plug
    if @smart_plug.save!
      render json: { "Stefan says, you created: " => @smart_plug }, status: :created
      # render :show, status: :created
    else
      render_error
    end
  end

  private

  def set_smart_plug
    @smart_plug = SmartPlug.find(params[:id])
    authorize @smart_plug # For Pundit
  end

  def smart_plug_params
    params.require(:smart_plug).permit(:actual, :daily)
  end

  def render_error
    render json: { errors: @plug.errors.full_messages }, status: :unprocessable_entity
  end
end
