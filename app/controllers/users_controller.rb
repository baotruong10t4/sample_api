class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [ :create ]
  before_action :find_user, only: [ :show, :update, :destroy ]

  def index
    @users = User.all
    render json: @users, each_serializer: UserSerializer, status: 200
  end

  def show
    render json: @user, serializer: UserSerializer, include: ["products"], status: 200
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      render json: @user, serializer: UserSerializer, status: 201
    else
      render json: { error: @user.errors.full_messages }, status: 503
    end
  end

  def update
    if @user.update(user_params)
      render json: @user, serializer: UserSerializer, status: 200
    else
      render json: { error: @user.errors.full_messages }, status: 503
    end
  end

  def destroy
    if @user
      @user.destroy
      render json: { message: "User successfully deleted." }, status: 200
    else
      render json: { error: "User not found." }, status: 404
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :user_name, :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
