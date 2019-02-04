class Participant < ApplicationRecord
  belongs_to :registration
  has_one :event, through: :registration
  belongs_to :race

  # validates :address, presence: true
  # validates :birth_date, presence: true
  # validates :city, presence: true
  # validates :division, presence: true
  # validates :emergency_contact_name, presence: true
  # validates :emergency_contact_phone, presence: true
  validates :email,
    presence: true,
    uniqueness: {
      scope: :event,
      message: "Not unique for this event. Have you already registered?"
    },
    format: {
      with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i,
      message: "This email looks unusual. Please use a different one."
    }
  validates :first_name, presence: true
  validates :last_name, presence: true
  # validates :phone, presence: true
  validates :race, presence: true
  # validates :state, presence: true
  # validates :zip, presence: true
end
