class Company < ApplicationRecord
  multisearchable against: [:name]

  # Relationships
  has_many :brokers

  # Scopes
  scope :alphabetical, -> { order("name ASC") }

  # Validations
  validates_uniqueness_of :name, case_sensitive: false, message: "Name must be unique" # Validates presence of attribute as well

  # Callbacks
  before_destroy do
    verify_no_brokers_associated_with_company
    if errors.present?
      throw(:abort)
    end
  end

  private

  def verify_no_brokers_associated_with_company
    unless self.brokers.empty?
      errors.add(:base, "The company has associated brokers and cannot be deleted now.")
    end
  end
end
