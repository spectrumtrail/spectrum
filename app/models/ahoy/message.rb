module Ahoy
  class Message < ActiveRecord::Base
    self.table_name = "ahoy_messages"

    scope :subject_like, ->(term) { where('subject ILIKE ?', "%#{term}%") }
  end
end
