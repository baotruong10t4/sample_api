class AuthenticationController < ApplicationController
  skip_before_action :authenticate_user

  # POST /auth/login
  def login
    @user = User.find_by_email(params[:email].downcase)
    if @user.activated? == false
      render json: { error: "Account not activated. Please check your email for the activation link." }, status: 200
    elsif @user&.authenticate(params[:password])
      token = jwt_encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i

      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     username: @user.user_name }, status: :ok
    else
      render json: { error: "Invalid username or password" }, status: :unauthorized
    end
  end
end
