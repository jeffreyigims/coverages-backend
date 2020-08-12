Rails.application.routes.draw do
  "" " We do not need names for the routes or routes to get new and edit pages since 
      we mainly use react components as the front end which make calls to the database 
  " ""

  # Generic routes
  # We do not need routes to get new or update pages since those are handled by as components
  get "sports", to: "sports#index"
  get "sports/:id", to: "sports#show"
  post "sports", to: "sports#create"
  patch "sports/:id", to: "sports#update"
  delete "sports/:id", to: "sports#destroy"

  get "coverages", to: "coverages#index"
  get "coverages/:id", to: "coverages#show"
  post "coverages", to: "coverages#create"
  patch "coverages/:id", to: "coverages#update"
  patch "coverages/verify/:id", to: "coverages#verify"
  delete "coverages/:id", to: "coverages#destroy"

  get "leagues", to: "leagues#index"
  get "leagues/:id", to: "leagues#show"
  post "leagues", to: "leagues#create"
  patch "leagues/:id", to: "leagues#update"
  delete "leagues/:id", to: "leagues#destroy"

  get "clubs", to: "clubs#index"
  get "clubs/:id", to: "clubs#show"
  post "clubs", to: "clubs#create"
  patch "clubs/:id", to: "clubs#update"
  delete "clubs/:id", to: "clubs#destroy"

  get "groups", to: "groups#index"
  get "groups/:id", to: "groups#show"
  post "groups", to: "groups#create"
  patch "groups/:id", to: "groups#update"
  delete "groups/:id", to: "groups#destroy"

  get "categories", to: "categories#index"
  get "categories/:id", to: "categories#show"
  post "categories", to: "categories#create"
  patch "categories/:id", to: "categories#update"
  delete "categories/:id", to: "categories#destroy"

  get "sub_categories/:id", to: "sub_categories#show"
  post "sub_categories", to: "sub_categories#create"
  patch "sub_categories/:id", to: "sub_categories#update"
  delete "sub_categories/:id", to: "sub_categories#destroy"

  get "carriers", to: "carriers#index"
  get "carriers/:id", to: "carriers#show"
  post "carriers", to: "carriers#create"
  patch "carriers/:id", to: "carriers#update"
  delete "carriers/:id", to: "carriers#destroy"

  get "companies", to: "companies#index"
  get "companies/:id", to: "companies#show"
  post "companies", to: "companies#create"
  patch "companies/:id", to: "companies#update"
  delete "companies/:id", to: "companies#destroy"

  get "brokers", to: "brokers#index"
  get "brokers/:id", to: "brokers#show"
  post "brokers", to: "brokers#create"
  patch "brokers/:id", to: "brokers#update"
  delete "brokers/:id", to: "brokers#destroy"

  get "users", to: "users#index"
  get "users/:id", to: "users#show"
  post "users", to: "users#create"
  patch "users/:id", to: "users#update"
  delete "users/:id", to: "users#destroy"

  post "user_clubs", to: "user_clubs#create"
  delete "user_clubs/:id", to: "user_clubs#destroy"

  # Routes for intermediary tables
  # We do not need to update or get individual entries
  post "coverage_carriers", to: "coverage_carriers#create"
  delete "coverage_carriers/:id", to: "coverage_carriers#destroy"

  post "coverage_brokers", to: "coverage_brokers#create"
  delete "coverage_brokers/:id", to: "coverage_brokers#destroy"

  post "club_groups", to: "club_groups#create"
  delete "club_groups/:id", to: "club_groups#destroy"

  get "search", to: "search#search"
  get "metrics", to: "metrics#metrics"
  post "user_token", to: "user_token#create"
end
