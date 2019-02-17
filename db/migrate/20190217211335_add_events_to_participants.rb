class AddEventsToParticipants < ActiveRecord::Migration[5.2]
  def change
    add_reference :participants, :event, foreign_key: true, index: true
    update_existing_participants
  end

  def update_existing_participants
    Participant.find_each { |p| p.update(event_id: p.race.event_id) }
  end
end
