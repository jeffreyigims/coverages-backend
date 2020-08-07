class Sport < ApplicationRecord
  searchkick
  Sport.reindex

  # Relationships
  has_many :leagues
  has_many :clubs, through: :leagues

  # Scopes
  scope :alphabetical, -> { order("name ASC") }

  # Validations
  validates_uniqueness_of :name, case_sensitive: false, message: "must be unique" # Validates presence of attribute as well

  # Callbacks
  before_destroy do
    verify_no_leagues_associated_with_sport
    if errors.present?
      throw(:abort)
    end
  end

  private

  def verify_no_leagues_associated_with_sport
    unless self.leagues.empty?
      errors.add(:base, "The sport has associated leagues and cannot be deleted now.")
    end
  end
end
