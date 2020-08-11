class CoverageBrokersController < ApplicationController
  before_action :authenticate_user
  before_action :set_coverage_broker, only: [:destroy]

  def create
    @coverage_broker = CoverageBroker.new(coverage_broker_params)
    if @coverage_broker.save
      render json: CoverageBrokerSerializer.new(@coverage_broker).serializable_hash
    else
      render json: @coverage_broker.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @coverage_broker.destroy
    if @coverage_broker.destroyed?
      render json: CoverageBrokerSerializer.new(@coverage_broker).serializable_hash
    else
      render json: @coverage_broker.errors, status: :unprocessable_entity
    end
  end

  private

  def set_coverage_broker
    @coverage_broker = CoverageBroker.find(params[:id])
  end

  def coverage_broker_params
    params.require(:coverage_broker).permit(:id, :broker_id, :coverage_id)
  end
end
