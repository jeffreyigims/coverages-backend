class BrokersController < ApplicationController
  before_action :set_broker, only: [:show, :update, :destroy]

  include Filterable
  include Orderable

  BOOLEAN_FILTERING_PARAMS = [[]]
  PARAM_FILTERING_PARAMS = []
  ORDERING_PARAMS = []

  def index
    @brokers = boolean_filter(Broker.alphabetical, BOOLEAN_FILTERING_PARAMS)
    @brokers = param_filter(@brokers, PARAM_FILTERING_PARAMS)
    @brokers = order(@brokers, ORDERING_PARAMS)
    respond_to do |format|
      format.html { @brokers }
      format.json { render json: BrokerTableSerializer.new(@brokers).serializable_hash }
    end
  end

  def show
    respond_to do |format|
      format.html { @broker }
      format.json { render json: BrokerSerializer.new(@broker).serializable_hash }
    end
  end

  def create
    @broker = Broker.new(broker_params)
    if @broker.save
      render json: BrokerSerializer.new(@broker).serializable_hash
    else
      render json: @broker.errors, status: :unprocessable_entity
    end
  end

  def update
    if @broker.update(broker_params)
      render json: BrokerSerializer.new(@broker).serializable_hash
    else
      render json: @broker.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @broker.destroy
    if @broker.destroyed?
      render json: BrokerSerializer.new(@broker).serializable_hash
    else
      render json: @broker.errors, status: :unprocessable_entity
    end
  end

  private

  def set_broker
    @broker = Broker.find(params[:id])
  end

  def broker_params
    params.require(:broker).permit(:id, :name, :company_id)
  end
end
