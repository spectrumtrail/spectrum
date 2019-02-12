class AddRegistrationToPayments < ActiveRecord::Migration[5.2]
  def change
    add_reference :payments, :registration, foreign_key: true, after: :id
  end
end
