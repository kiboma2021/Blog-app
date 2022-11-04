class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def authenticate
    command = AuthenticateUser.call(params[:email], params[:password])

    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  def signup
    @user = User.new(
      name: params[:name], photo: params[:photo], bio: params[:bio], posts_counter: 0,
      email: params[:email], password: params[:password],
      password_confirmation: params[:password_confirmation]
    )
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
