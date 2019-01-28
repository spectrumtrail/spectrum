class AddEmailToParticipants < ActiveRecord::Migration[5.2]
  def change
    add_column :participants, :email, :string
  end
end
