class SportsController < ApplicationController
  before_action :set_sport, only: [:show, :update, :destroy]

  include Filterable
  include Orderable

  BOOLEAN_FILTERING_PARAMS = [[]]
  PARAM_FILTERING_PARAMS = []
  ORDERING_PARAMS = []

  def index
    @sports = boolean_filter(Sport.alphabetical, BOOLEAN_FILTERING_PARAMS)
    @sports = param_filter(@sports, PARAM_FILTERING_PARAMS)
    @sports = order(@sports, ORDERING_PARAMS)
    render json: SportSerializer.new(@sports).serializable_hash
  end

  def show
    render json: SportSerializer.new(@sport).serializable_hash
  end

  def create
    @sport = Sport.new(sport_params)
    if @sport.save
      render json: SportSerializer.new(@sport).serializable_hash
    else 
      render json: @sport.errors, status: :unprocessable_entity
    end
  end

  def update
    if @sport.update(sport_params)
      render json: SportSerializer.new(@sport).serializable_hash
    else
      render json: @sport.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @sport.destroy
    if @sport.destroyed?
      render json: SportSerializer.new(@sport).serializable_hash
    else 
      render json: @sport.errors, status: :unprocessable_entity
    end
  end

  private

  def set_sport
    @sport = Sport.find(params[:id])
  end

  def sport_params
    params.require(:sport).permit(:id, :name)
  end
end
