class Registration < ApplicationRecord
  visitable :ahoy_visit
  attr_accessor :discount_code_text

  serialize :steps_seen, Array
  serialize :steps_completed, Array

  has_secure_token

  belongs_to :event
  belongs_to :discount_code, counter_cache: true, optional: true
  belongs_to :user, optional: true
  has_one :location, through: :event
  has_one :participant, dependent: :destroy
  has_one :race, through: :participant
  accepts_nested_attributes_for :participant, allow_destroy: :true, update_only: true
  has_one :payment
  accepts_nested_attributes_for :payment, update_only: true

  validates :accepts_refund_terms, acceptance: true, if: :validate_payment?

  scope :completed, -> { where.not(completed_at: nil) }
  scope :incomplete, -> { where(completed_at: nil) }
  scope :cancelled, -> { where.not(cancelled_at: nil) }
  scope :not_cancelled, -> { where(cancelled_at: nil) }
  scope :archived, -> { where.not(archived_at: nil) }
  scope :not_archived, -> { where(archived_at: nil) }
  scope :last_thirty_days, -> { where(started_at: 30.days.ago..Time.now) }
  scope :over_twenty_four_hours, -> { where("started_at <= ?", 24.hours.ago) }
  scope :complete, -> { completed.not_cancelled }
  scope :in_progress, -> { incomplete.not_cancelled }
  scope :abandoned, -> { incomplete.not_cancelled.last_thirty_days.over_twenty_four_hours }
  scope :cancelled_ordered_by_cancelled_at, -> { cancelled.order(cancelled_at: :desc) }

  def archived?
    archived_at.present?
  end

  def complete?
    completed_at.present? && paid?
  end

  def incomplete?
    completed_at.nil? || payment.nil?
  end

  def default_billing_email
    billing_email ||= participant.email
  end

  def last_step_seen
    steps_seen.last
  end

  def last_step_completed
    steps_completed.last
  end

  def paid?
    payment.present?
  end

  def cancelled?
    cancelled_at.present?
  end

  def to_param
    [id, token].join("-")
  end

  private

  def validate_payment?
    step_to_validate == "payment"
  end
end
