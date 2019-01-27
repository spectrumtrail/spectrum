class AddStartingNameToRegistrations < ActiveRecord::Migration[5.2]
  def change
    add_column :registrations, :starting_name, :string
    rename_column :registrations, :billing_email, :starting_email
  end
end
