class User < ApplicationRecord
  include AppHelpers::Deletions
  has_secure_password
  searchkick

  # Relationships
  has_many :user_clubs
  has_many :coverages
  has_many :clubs, through: :user_club

  # Scopes
  scope :alphabetical, -> { order("last_name, first_name") }

  # Validations
  validates_uniqueness_of :user_name, case_sensitive: false, message: "Username must be unique" # Validates presence of attribute as well
  validates_inclusion_of :role, in: %w[admin employee contact], message: "is not an option"
  validates_presence_of :password, on: :create
  validates_presence_of :password_confirmation, on: :create
  validates_confirmation_of :password, on: :create, message: "does not match"
  validates_length_of :password, minimum: 4, message: "must be at least 4 characters long", allow_blank: true

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

  def self.from_token_request(request)
    username = request.params["auth"] && request.params["auth"]["username"]
    user = self.find_by username: username
    if user.nil?
      raise Knock.not_found_exception_class_name
    else
      return user
    end
  end

  private

  # def destroy_contacts
  #   self.user_clubs.each { |i| i.destroy }
  # end
end
