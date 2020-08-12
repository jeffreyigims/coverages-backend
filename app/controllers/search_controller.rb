class SearchController < ApplicationController
  before_action :authenticate_user

  def search
    parameter = params[:search]
    results = PgSearch.multisearch(parameter)
    results = results.map { |i| i.searchable }
    render json: { data: results }
  end
end
