class CoveragesController < ApplicationController
  before_action :authenticate_user
  before_action :set_coverage, only: [:show, :update, :verify, :destroy]

  include Filterable
  include Orderable

  BOOLEAN_FILTERING_PARAMS = [[:verified, :unverified]]
  PARAM_FILTERING_PARAMS = [:for_league, :for_club, :for_group, :for_club_group, :for_carrier, :for_broker, :for_user, :for_category, :for_sub_category, :for_broker]
  ORDERING_PARAMS = [:most_recent, :most_recently_updated, :end_date, :start_date]

  def index
    @coverages = boolean_filter(Coverage, BOOLEAN_FILTERING_PARAMS)
    @coverages = param_filter(@coverages, PARAM_FILTERING_PARAMS)
    @coverages = order(@coverages, ORDERING_PARAMS)
    @coverages = @coverages.paginate(page: params[:page]).per_page(10)
    render json: {
      page: @coverages.current_page,
      pages: @coverages.total_pages,
      objects: CoverageSerializer.new(@coverages).serializable_hash,
    }
  end

  def show
    render json: CoverageSerializer.new(@coverage).serializable_hash
  end

  def create
    @coverage = Coverage.new(coverage_params)
    @coverage.user_id = current_user.id
    if @coverage.save
      render json: CoverageSerializer.new(@coverage).serializable_hash
    else
      render json: @coverage.errors, status: :unprocessable_entity
    end
  end

  def update
    if @coverage.update(coverage_params)
      render json: CoverageSerializer.new(@coverage).serializable_hash
    else
      render json: @coverage.errors, status: :unprocessable_entity
    end
  end

  def verify
    @coverage.verify
  end

  def destroy
    @coverage.destroy
    if @coverage.destroyed?
      render json: CoverageSerializer.new(@coverage).serializable_hash
    else
      render json: @coverage.errors, status: :unprocessable_entity
    end
  end

  private

  def set_coverage
    @coverage = Coverage.find(params[:id])
  end

  def coverage_params
    params.require(:coverage).permit(:id, :has_coverage_line, :notes, :start_date, :end_date, :verified, :sub_category_id, :club_group_id)
  end
end
