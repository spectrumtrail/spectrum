class Participant < ApplicationRecord
  belongs_to :registration
  belongs_to :race

  validates :race, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true
  validates :email, presence: true
  validates :birth_date, presence: true
  validates :division, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :emergency_contact_name, presence: true
  validates :emergency_contact_phone, presence: true
  validates :medical_conditions, presence: true

  def charge_for_race
    100
  end
end
