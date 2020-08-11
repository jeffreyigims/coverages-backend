class SearchController < ApplicationController
  before_action :authenticate_user
  def search
    parameter = params[:search]
    results = {}
    results["sports"] = Sport.search(parameter)
    results["leagues"] = League.search(parameter)
    results["clubs"] = Club.search(parameter)
    results["groups"] = Group.search(parameter)
    results["categories"] = Category.search(parameter)
    results["sub_categories"] = SubCategory.search(parameter)
    results["companies"] = Company.search(parameter)
    results["brokers"] = Broker.search(parameter)
    results["carriers"] = Carrier.search(parameter)
    results["users"] = User.search(parameter)
    hits = results.inject(0) { |total, (k, v)| total += v.total_count }
    render json: { data: results, hits: hits }
  end
end
