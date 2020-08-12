class League < ApplicationRecord
  multisearchable against: [:name]

  # Relationships
  belongs_to :sport
  has_many :clubs
  has_many :club_groups, through: :clubs

  # Scopes
  scope :alphabetical, -> { order("name ASC") }
  scope :for_sport, ->(sport_id) { where("sport_id = ?", sport_id) }

  # Callbacks
  before_destroy do
    verify_no_clubs_associated_with_league
    if errors.present?
      throw(:abort)
    end
  end

  private

  def verify_no_clubs_associated_with_league
    unless self.clubs.empty?
      errors.add(:base, "The league has associated clubs and cannot be deleted now.")
    end
  end
end
