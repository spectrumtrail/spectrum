class AddRegistrationOpensAtToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :registration_opens_at, :datetime
    add_column :events, :registration_closes_at, :datetime
  end
end
