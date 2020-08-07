class Group < ApplicationRecord
  searchkick
  Group.reindex

  # Relationships
  has_many :club_groups
  has_many :clubs, through: :club_groups
  has_many :coverages, through: :club_groups

  # Scopes
  scope :alphabetical, -> { order("name ASC") }

  # Callbacks
  before_destroy do
    verify_no_clubs_associated_with_group
    if errors.present?
      throw(:abort)
    end
  end

  private

  def verify_no_clubs_associated_with_group
    unless self.club_groups.empty?
      errors.add(:base, "The group has associated clubs and cannot be deleted now.")
    end
  end
end
