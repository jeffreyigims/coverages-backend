class CoveragesController < ApplicationController
  before_action :set_coverage, only: [:show, :update, :verify, :destroy]

  include Filterable
  include Orderable

  BOOLEAN_FILTERING_PARAMS = [[:verified, :unverified]]
  PARAM_FILTERING_PARAMS = [:for_league, :for_club, :for_club_group, :for_carrier, :for_broker, :for_user, :for_sub_category, :for_broker]
  ORDERING_PARAMS = []

  def index
    @coverages = boolean_filter(Coverage.most_recent, BOOLEAN_FILTERING_PARAMS)
    @coverages = param_filter(@coverages, PARAM_FILTERING_PARAMS)
    @coverages = order(@coverages, ORDERING_PARAMS)
    @coverages = @coverages.paginate(page: params[:page]).per_page(10)
    respond_to do |format|
      format.html { @coverages }
      format.json {
        render json: {
                 page: @coverages.current_page,
                 pages: @coverages.total_pages,
                 objects: CoverageSerializer.new(@coverages).serializable_hash,
               }
      }
    end
  end

  def show
    respond_to do |format|
      format.html { @coverage }
      format.json { render json: CoverageSerializer.new(@coverage).serializable_hash }
    end
  end

  def create
    @coverage = Coverage.new(coverage_params)
    @coverage.user_id = 1
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
    if !@coverage.destroyed?
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
