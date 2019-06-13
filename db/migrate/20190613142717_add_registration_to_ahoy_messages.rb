class AddRegistrationToAhoyMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :ahoy_messages, :registration_id, :integer
  end
end
