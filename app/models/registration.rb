class Registration < ApplicationRecord
  has_secure_token

  belongs_to :event
  has_one :location, through: :event
  has_many :participants
  accepts_nested_attributes_for :participants, allow_destroy: :true

  def complete?
    status == 'complete'
  end
end
