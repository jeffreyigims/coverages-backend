class CoverageCarriersController < ApplicationController
  before_action :set_coverage_carrier, only: [:destroy]

  def create
    @coverage_carrier = CoverageCarrier.new(coverage_carrier_params)
    if @coverage_carrier.save
      render json: CoverageCarrierSerializer.new(@coverage_carrier).serializable_hash
    else
      render json: @coverage_carrier.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @coverage_carrier.destroy
    if @coverage_carrier.destroyed?
      render json: CoverageCarrierSerializer.new(@coverage_carrier).serializable_hash
    else
      render json: @coverage_carrier.errors, status: :unprocessable_entity
    end
  end

  private

  def set_coverage_carrier
    @coverage_carrier = CoverageCarrier.find(params[:id])
  end

  def coverage_carrier_params
    params.require(:coverage_carrier).permit(:id, :carrier_id, :coverage_id)
  end
end
