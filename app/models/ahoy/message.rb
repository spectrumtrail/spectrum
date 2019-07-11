module Ahoy
  class Message < ActiveRecord::Base
    self.table_name = "ahoy_messages"

    scope :subject_like, ->(term) { where('subject ILIKE ?', "%#{term}%") }
    scope :body_like, ->(term) { where('body ILIKE ?', "%#{term}%") }
  end
end
