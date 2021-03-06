class User < ApplicationRecord
  has_many :visits, class_name: "Ahoy::Visit"
  has_many :registrations

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable


  SIGN_UP_KEYS = [
    :address,
    :birth_date,
    :city,
    :division,
    :first_name,
    :last_name,
    :originating_registration_id,
    :phone,
    :state,
    :zip,
  ].freeze

  has_one_attached :avatar

  def full_name
    "#{first_name} #{last_name}"
  end
end
