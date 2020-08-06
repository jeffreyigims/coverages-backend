class ClubGroup < ApplicationRecord

  # Relationships
  belongs_to :club
  belongs_to :group
  has_many :coverages
  has_one :league, through: :club

  # Scopes
  scope :for_club, ->(club_id) { where(club_id: club_id) }
  scope :alphabetical, -> { joins(:group).order("group.name ASC") }

  # Callbacks
  before_create do
    verify_no_duplicates
    if errors.present?
      throw(:abort)
    end
  end

  before_destroy do
    verify_no_coverages_associated_with_club_group
    if errors.present?
      throw(:abort)
    end
  end

  private

  def verify_no_duplicates
    current_club_groups = ClubGroup.for_club(self.club.id)
    current_club_groups.each do |club_group|
      if club_group.group_id == self.group_id
        errors.add(:base, "The club already has an association to the group.")
      end
    end
  end

  def verify_no_coverages_associated_with_club_group
    unless self.coverages.empty?
      errors.add(:base, "The group has associated coverages and cannot be deleted now.")
    end
  end
end
