class AddAcceptsEventWaiverToParticipants < ActiveRecord::Migration[5.2]
  def change
    add_column :participants, :accepts_waiver, :boolean
  end
end
