class ApplicationDecorator < Draper::Decorator
  delegate_all

  def created_at_with_zone
    Time.use_zone("Central Time (US & Canada)") do
      created_at.strftime("%B %e, %Y %l:%M%P %Z")
    end
  end
end
