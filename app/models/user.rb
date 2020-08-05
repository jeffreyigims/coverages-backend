class User < ApplicationRecord
  include AppHelpers::Deletions
  has_secure_password

  # Relationships
  has_many :user_clubs
  has_many :coverages
  has_many :clubs, through: :user_club

  # Scopes
  scope :alphabetical, -> { order("last_name, first_name") }

  # Callbacks
  # Only allow destroy if no associated coverages and no associated contact
  # before_destroy -> { cannot_destroy_object() }

  # For authentication
  ROLES_LIST = [["Administrator", "admin"], ["Employee", "employee"], ["Contact", "contact"]].freeze

  def role?(authorized_role)
    return false if role.nil?
    role.downcase.to_sym == authorized_role
  end

  # login by username
  def User.authenticate(username, password)
    find_by_username(username).try(:authenticate, password)
  end

  def current_club
    contacts = self.user_clubs
    contacts.empty? ? nil : contacts.first.club
  end

  def current_contact
    contacts = self.user_clubs
    contacts.empty? ? nil : contacts.first
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end

  private

  # def destroy_contacts
  #   self.user_clubs.each { |i| i.destroy }
  # end
end
