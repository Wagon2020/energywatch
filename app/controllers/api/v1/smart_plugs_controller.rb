class Api::V1::SmartPlugsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]
  def create
    @plug = SmartPlug.new(plug_params)
    @plug.user = current_user
    authorize @plug
    if @plug.save
      render :show, status: :created
    else
      render_error
    end
  end

  private

  def plug_params
    params.require(:plug).permit(:actual, :daily)
  end

  def render_error
    render json: { errors: @plug.errors.full_messages },
      status: :unprocessable_entity
  end

end

