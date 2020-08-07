class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  include Filterable
  include Orderable

  BOOLEAN_FILTERING_PARAMS = [[]]
  PARAM_FILTERING_PARAMS = []
  ORDERING_PARAMS = []

  def index
    @users = boolean_filter(User.alphabetical, BOOLEAN_FILTERING_PARAMS)
    @users = param_filter(@users, PARAM_FILTERING_PARAMS)
    @users = order(@users, ORDERING_PARAMS)
    render json: UserTableSerializer.new(@users).serializable_hash
  end

  def show
    render json: UserTableSerializer.new(@user).serializable_hash
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: UserSerializer.new(@user).serializable_hash
    else 
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: UserSerializer.new(@user).serializable_hash
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    if @user.destroyed?
      render json: UserSerializer.new(@user).serializable_hash
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:id, :first_name, :last_name, :role, :username, :password, :password_confirmation)
  end
end
