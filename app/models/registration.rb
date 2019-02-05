class Registration < ApplicationRecord
  serialize :steps_seen, Array
  serialize :steps_completed, Array

  has_secure_token

  belongs_to :event
  has_one :location, through: :event
  has_many :participants, dependent: :destroy
  accepts_nested_attributes_for :participants, allow_destroy: :true

  def complete?
    step_to_validate == "complete"
  end

  def to_param
    [id, token].join("-")
  end
end
