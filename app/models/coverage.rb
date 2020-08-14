class Coverage < ApplicationRecord

  # Relationships
  belongs_to :club_group
  belongs_to :sub_category
  belongs_to :user
  has_one :group, through: :club_group
  has_one :club, through: :club_group
  has_one :category, through: :sub_category
  has_one :league, through: :club
  has_one :sport, through: :league
  has_many :coverage_carriers
  has_many :coverage_brokers
  has_many :carriers, through: :coverage_carriers
  has_many :brokers, through: :coverage_brokers

  # Scopes
  scope :verified, -> { where(verified: true) }
  scope :unverified, -> { where(verified: false) }
  scope :for_league, ->(league_id) { joins(:club_group).joins(:club).where("league_id = ?", league_id) }
  scope :for_club, ->(club_id) { joins(:club_group).where("club_id = ?", club_id) }
  scope :for_carrier, ->(carrier_id) { joins(:coverage_carriers).where("carrier_id = ?", carrier_id) }
  scope :for_broker, ->(broker_id) { joins(:coverage_brokers).where("broker_id = ?", broker_id) }
  scope :for_club_group, ->(club_group_id) { where("club_group_id = ?", club_group_id) }
  scope :for_user, ->(user_id) { where("user_id = ?", user_id) }
  scope :for_sub_category, ->(sub_category_id) { where("sub_category_id = ?", sub_category_id) }
  scope :chronological, -> { order(Arel.sql("start_date DESC, end_date IS NOT NULL, end_date DESC")) }
  scope :most_recent, -> { order(Arel.sql("created_at DESC")) }

  # Validations
  validates_date :start_date, allow_blank: true
  validates_date :end_date, on_or_after: :start_date, allow_blank: true, on_or_after_message: "The end date must be after the start date."
  validates_inclusion_of :has_coverage_line, in: %w[yes no unknown], message: "is not an option"

  # Callbacks
  before_destroy :destroy_attachments

  def verify
    self.update_attribute("verified", true)
    self.reload
  end

  private

  def destroy_attachments
    self.coverage_carriers.each { |i| i.destroy }
    self.coverage_brokers.each { |i| i.destroy }
  end
end
