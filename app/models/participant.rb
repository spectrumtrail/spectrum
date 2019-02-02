class Participant < ApplicationRecord
  belongs_to :registration
  has_one :event, through: :registration
  belongs_to :race

  validates :race, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true
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
  validates :birth_date, presence: true
  validates :division, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :emergency_contact_name, presence: true
  validates :emergency_contact_phone, presence: true

  def charge_for_race
    100
  end
end
