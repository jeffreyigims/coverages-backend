class GroupsController < ApplicationController
  before_action :authenticate_user
  before_action :set_group, only: [:show, :update, :destroy]

  include Filterable
  include Orderable

  BOOLEAN_FILTERING_PARAMS = [[]]
  PARAM_FILTERING_PARAMS = []
  ORDERING_PARAMS = []

  def index
    @groups = boolean_filter(Group.alphabetical, BOOLEAN_FILTERING_PARAMS)
    @groups = param_filter(@groups, PARAM_FILTERING_PARAMS)
    @groups = order(@groups, ORDERING_PARAMS)
    render json: GroupSerializer.new(@groups).serializable_hash
  end

  def show
    render json: GroupSerializer.new(@group).serializable_hash 
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      render json: GroupSerializer.new(@group).serializable_hash
    else 
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  def update
    if @group.update(group_params)
      render json: GroupSerializer.new(@group).serializable_hash
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @group.destroy
    if @group.destroyed?
      render json: GroupSerializer.new(@group).serializable_hash
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:id, :name)
  end
end
