class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable

  has_one_attached :avatar

  def full_name
    "#{first_name} #{last_name}"
  end
end
