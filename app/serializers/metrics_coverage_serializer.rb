class MetricsCoverageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :has_coverage_line, :verified

  attribute :sport do |object|
    object.sport.name
  end

  attribute :league do |object|
    object.league.name
  end

  attribute :club do |object|
    object.club.name
  end

  attribute :group do |object|
    object.group.name
  end

  attribute :category do |object|
    object.category.name
  end

  attribute :sub do |object|
    object.sub_category.name
  end

  attribute :carrier do |object|
    target = object.coverage_carriers
    target.empty? ? "" : target.first.carrier.name
  end

  attribute :broker do |object|
    target = object.coverage_brokers
    target.empty? ? "" : target.first.broker.company.name
  end
end
