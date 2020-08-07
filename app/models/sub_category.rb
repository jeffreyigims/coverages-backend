class SubCategory < ApplicationRecord
  searchkick
  SubCategory.reindex

  # Relationships
  belongs_to :category
  has_many :coverages

  # Scopes
  scope :alphabetical, -> { order("name ASC") }

  # Callbacks
  before_destroy do
    verify_no_coverages_associated_with_sub_category
    if errors.present?
      throw(:abort)
    end
  end

  private

  def verify_no_coverages_associated_with_sub_category
    unless self.coverages.empty?
      errors.add(:base, "The category has associated coverages and cannot be deleted now.")
    end
  end
end
