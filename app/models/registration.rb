class Registration < ApplicationRecord
  has_secure_token

  belongs_to :event
  has_one :location, through: :event
  has_many :participants
  accepts_nested_attributes_for :participants, allow_destroy: :true

  def calculate_total_charge
    total = 0
    participants.each do |participant|
      total += participant.charge_for_race
    end
  end
end
