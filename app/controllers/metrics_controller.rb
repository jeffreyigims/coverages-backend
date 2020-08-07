class MetricsController < ApplicationController
  def metrics
    @coverages = []
    # if current_user.role?(:contact)
    #   @coverages = Coverages.for_club(current_user.current_club) unless @club.nil?
    # else
      @coverages = Coverage.all
    # end
    render json: MetricsCoverageSerializer.new(@coverages).serializable_hash
  end
end
