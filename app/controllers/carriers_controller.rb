class CarriersController < ApplicationController
  before_action :authenticate_user
  before_action :set_carrier, only: [:show, :update, :destroy]

  include Filterable
  include Orderable

  BOOLEAN_FILTERING_PARAMS = [[]]
  PARAM_FILTERING_PARAMS = []
  ORDERING_PARAMS = []

  def index
    @carriers = boolean_filter(Carrier.alphabetical, BOOLEAN_FILTERING_PARAMS)
    @carriers = param_filter(@carriers, PARAM_FILTERING_PARAMS)
    @carriers = order(@carriers, ORDERING_PARAMS)
    render json: CarrierTableSerializer.new(@carriers).serializable_hash
  end

  def show
    render json: CarrierSerializer.new(@carrier).serializable_hash
  end

  def create
    @carrier = Carrier.new(carrier_params)
    if @carrier.save
      render json: CarrierSerializer.new(@carrier).serializable_hash
    else
      render json: @carrier.errors, status: :unprocessable_entity
    end
  end

  def update
    if @carrier.update(carrier_params)
      render json: CarrierSerializer.new(@carrier).serializable_hash
    else
      render json: @carrier.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @carrier.destroy
    if @carrier.destroyed?
      render json: CarrierSerializer.new(@carrier).serializable_hash
    else
      render json: @carrier.errors, status: :unprocessable_entity
    end
  end

  private

  def set_carrier
    @carrier = Carrier.find(params[:id])
  end

  def carrier_params
    params.require(:carrier).permit(:id, :name)
  end
end
