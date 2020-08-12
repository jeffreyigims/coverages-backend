class MetricsController < ApplicationController
  before_action :authenticate_user
  def metrics
    attributes = " has_coverage_line, verified, sub_categories.name, categories.name, groups.name,
                   clubs.name, leagues.name, sports.name, carriers.name, companies.name "
    sql = "Select" + attributes + "from coverages JOIN sub_categories on sub_categories.id = coverages.sub_category_id
                                                  JOIN categories on categories.id = sub_categories.category_id
                                                  JOIN club_groups on club_groups.id = coverages.club_group_id
                                                  JOIN groups on groups.id = club_groups.group_id
                                                  JOIN clubs on clubs.id = club_groups.club_id
                                                  JOIN leagues on leagues.id = clubs.league_id
                                                  JOIN sports on sports.id = leagues.sport_id
                                                  FULL OUTER JOIN coverage_carriers on coverage_carriers.coverage_id = coverages.id
                                                  FULL OUTER JOIN coverage_brokers on coverage_brokers.coverage_id = coverages.id
                                                  LEFT JOIN carriers on carriers.id = coverage_carriers.carrier_id
                                                  LEFT JOIN brokers on brokers.id = coverage_brokers.broker_id
                                                  LEFT JOIN companies on companies.id = brokers.company_id"
    coverages = ActiveRecord::Base.connection.execute(sql)
    render json: { data: coverages.values }
  end
end
