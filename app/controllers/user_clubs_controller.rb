class UserClubsController < ApplicationController
  before_action :authenticate_user
  before_action :set_user_club, only: [:destroy]

  def create
    @user_club = UserClub.new(user_club_params)
    if @user_club.save
      render json: @user_club
    else
      render json: @user_club.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user_club.destroy
    if @user_club.destroyed?
      render json: @user_club
    else
      render json: @user_club.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user_club
    @user_club = UserClub.find(params[:id])
  end

  def user_club_params
    params.require(:user_club).permit(:id, :active, :user_id, :club_id)
  end
end
