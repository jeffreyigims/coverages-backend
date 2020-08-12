class Club < ApplicationRecord
  multisearchable against: [:name]

  # Relationships
  belongs_to :league
  has_one :sport, through: :league
  has_many :club_groups
  has_many :coverages, through: :club_groups
  has_many :groups, through: :club_groups

  # Scopes
  scope :alphabetical, -> { order("name ASC") }
  scope :for_league, ->(league_id) { where("league_id = ?", league_id) }

  # Validations
  validates_presence_of :name

  # Callbacks
  before_destroy do
    verify_no_coverages_associated_with_club
    if errors.present?
      throw(:abort)
    else
      delete_club_groups
    end
  end

  private

  def verify_no_coverages_associated_with_club
    unless self.coverages.empty?
      errors.add(:base, "The club has associated groups and cannot be deleted now.")
    end
  end

  def delete_club_groups
    self.club_groups.each { |i| i.destroy }
  end
end
