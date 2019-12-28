class HomePageImage < ApplicationRecord
  include RankedModel
  ranks :display_order

  has_one_attached :image

  scope :not_hidden, -> { where(hidden: false) }
end
