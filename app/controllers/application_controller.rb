class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :authenticate_request, if: :json_request
  attr_reader :current_user

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end

  def json_request
    request.format.json?
  end

  protected

  def configure_permitted_parameters
    attributes = %i[name email password password_confirmation current_password username surname]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
  end
end
