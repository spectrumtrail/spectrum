class Participant < ApplicationRecord
  belongs_to :registration
  belongs_to :race

  def charge_for_race
    100
  end
end
