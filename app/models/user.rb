class User < ApplicationRecord
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
