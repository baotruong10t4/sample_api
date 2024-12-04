class AccountActivationsController < ApplicationController
  skip_before_action :authenticate_user

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      render json: { message: "Account activated!" }, status: 200
    else
      render json: { message: "Invalid activation link" }, status: 200
    end
  end
end
