class Holiday < ApplicationRecord
  validates :occasion, presence: true
end
