class AddAcceptsRefundTermsToRegistrations < ActiveRecord::Migration[5.2]
  def change
    add_column :registrations, :accepts_refund_terms, :boolean
  end
end
