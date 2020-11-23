class Volunteer < ApplicationRecord
  belongs_to :volunteer_position

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true
  validates :email, presence: true, uniqueness: { message: "We\'re sorry, you can only volunteer for one event at a time." }
  validates :time, presence: true
end
