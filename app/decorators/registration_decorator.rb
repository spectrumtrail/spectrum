class RegistrationDecorator < Draper::Decorator
  delegate_all

  def event_name
    event.name
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def race_name
    race.name
  end

  def local_created_time
  end
end
