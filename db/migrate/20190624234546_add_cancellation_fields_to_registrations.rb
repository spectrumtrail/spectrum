class AddCancellationFieldsToRegistrations < ActiveRecord::Migration[5.2]
  def change
    add_column :registrations, :cancelled_at, :datetime
    add_column :registrations, :cancelled_by, :string
    add_column :registrations, :cancellation_reason, :string
    add_column :registrations, :admin_notes, :string
  end
end
