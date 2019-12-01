# This class archives a race _and_ its registrations.
class ArchivesRace
  attr_reader :race

  def initialize(race_id:)
    @race = Race.find race_id
  end

  def perform
    ActiveRecord::Base.transaction do
      race.update(archived_at: Time.current)
      update_race_registrations
    end

    OpenStruct.new(
      success?: true
    )
  end

  private

  def update_race_registrations
    registrations.update_all(archived_at: Time.current)
  end

  def registrations
    Registration.joins(:participant).where(participants: { race_id: race.id })
  end
end
