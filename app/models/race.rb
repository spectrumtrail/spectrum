class Race < ApplicationRecord
  belongs_to :event
  has_one :location, through: :event
  has_many :registrations

  validates :name, presence: true

  def name_with_event
    "#{event.name} #{name}"
  end
end
