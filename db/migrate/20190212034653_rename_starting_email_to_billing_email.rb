class RenameStartingEmailToBillingEmail < ActiveRecord::Migration[5.2]
  def change
    rename_column :registrations, :starting_email, :billing_email
  end
end
