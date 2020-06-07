class Api::V1::SmartPlugsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]
  before_action :set_smart_plug, only: [ :show ]

  def entry
    if params["smart_plug"]["todays_date"] == SmartPlug.last.todays_date
      update(params)
    else
      create(params["smart_plug"]["actual"])
    end
  end

  private

  def create(actual)
    @smart_plug = SmartPlug.new(smart_plug_params)
    @smart_plug.daily_hash = build_daily_hash(@smart_plug.daily_hash, actual)
    @smart_plug.user = current_user
    authorize @smart_plug
    if @smart_plug.save!
      render json: { "Stefan says, you created: " => @smart_plug }, status: :created
    else
      render_error
    end
  end

  def update(params)
    @smart_plug = SmartPlug.last
    @smart_plug.daily_hash = build_daily_hash(@smart_plug.daily_hash, params["smart_plug"]["actual"])
    authorize @smart_plug
    if @smart_plug.save!
      render json: { "Stefan says, you updated: " => @smart_plug }, status: :created
    else
      render_error
    end
  end

  def smart_plug_params
    params.require(:smart_plug).permit(:actual, :todays_date, :daily_hash, :yesterday)
  end

  def render_error
    render json: { errors: @plug.errors.full_messages }, status: :unprocessable_entity
  end

  def build_daily_hash(db_hash, actual)
    db_hash ? daily_hash = JSON(db_hash) : daily_hash = {}
    daily_hash[Time.now.strftime("%k:%M")] = actual
    JSON(daily_hash)
  end
end
