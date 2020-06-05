class Api::V1::SmartPlugsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]
  before_action :set_smart_plug, only: [ :show ]

  def create
    @smart_plug = SmartPlug.new(smart_plug_params)
    @smart_plug.daily_array = build_daily_array(params["smart_plug"])
    @smart_plug.user = current_user
    authorize @smart_plug
    if @smart_plug.save!
      render json: { "Stefan says, you created: " => @smart_plug }, status: :created
      # render :show, status: :created
    else
      render_error
    end
  end

  def index
    @smart_plug = SmartPlug.last
  end

  private

  def set_smart_plug
    @smart_plug = SmartPlug.find(params[:id])
    authorize @smart_plug # For Pundit
  end

  def smart_plug_params
    params.require(:smart_plug).permit(:actual, :daily, :daily_array)
  end

  def render_error
    render json: { errors: @plug.errors.full_messages }, status: :unprocessable_entity
  end

  def receive_db_array
    JSON(SmartPlug.last.daily_array)
  end

  def build_daily_array(payload)
    daily_array = receive_db_array
    if daily_array.empty?
      daily_array << Date.today.to_s.delete('-')
    end
    new_entry = [Time.now.strftime("%k:%M"), payload["actual"]]
    daily_array << new_entry
    JSON(daily_array)
  end
end
